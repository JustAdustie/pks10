package handlers

import (
	"net/http"
	"shopApi/models"

	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
)

func GetCart(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		userId := c.Param("userId")
		var cartItems []models.Cart

		err := db.Select(&cartItems, "SELECT c.user_id, p.product_id, p.image_url, p.name, p.description, p.features, p.price, c.quantity, p.stock FROM product p JOIN cart c ON p.product_id = c.product_id WHERE c.user_id = $1;", userId)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error":   "Ошибка получения содержимого корзины",
				"details": err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, cartItems)
	}
}

func AddToCart(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		userId := c.Param("userId")
		var item struct {
			ProductID int `json:"product_id"`
			Quantity  int `json:"quantity"`
		}
		if err := c.ShouldBindJSON(&item); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректные данные"})
			return
		}
		_, err := db.Exec("INSERT INTO Cart (user_id, product_id, quantity) VALUES ($1, $2, $3) ON CONFLICT (user_id, product_id) DO UPDATE SET quantity = Cart.quantity + $3",
			userId, item.ProductID, item.Quantity)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка добавления в корзину"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"message": "Товар добавлен в корзину"})
	}
}

func RemoveFromCart(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		userId := c.Param("userId")
		productId := c.Param("productId")
		_, err := db.Exec("DELETE FROM Cart WHERE user_id = $1 AND product_id = $2", userId, productId)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка удаления из корзины"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"message": "Товар удален из корзины"})
	}
}

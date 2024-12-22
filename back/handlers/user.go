package handlers

import (
	"net/http"
	"shopApi/models"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
)

func GetUser(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		userIdStr := c.Param("id")
		userId, err := strconv.Atoi(userIdStr)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректный ID пользователя"})
			return
		}

		var user models.User
		err = db.Get(&user, "SELECT * FROM users WHERE user_id = $1", userId)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{
				"error":   "Ошибка получения данных пользователя",
				"details": err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, user)
	}
}

// Обновление существующего пользователя по его ID
func UpdateUser(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		idStr := c.Param("userId")
		id, err := strconv.Atoi(idStr)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректный ID пользователя"})
			return
		}

		var user models.User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректные данные"})
			return
		}

		user.UserID = id
		query := `UPDATE Users SET username = :username, email = :email, phone_number = :phone, image_url = :image_url WHERE user_id = :user_id`

		_, err = db.NamedExec(query, &user)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка обновления данных пользователя"})
			return
		}

		c.JSON(http.StatusOK, user)
	}
}

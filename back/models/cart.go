package models

import "time"

type Cart struct {
	CartID      int       `db:"cart_id" json:"cart_id"`
	UserID      int       `db:"user_id" json:"user_id"`
	ProductID   int       `db:"product_id" json:"product_id"`
	ImageURL    string    `db:"image_url" json:"image_url"`
	Name        string    `db:"name" json:"name"`
	Description string    `db:"description" json:"description"`
	Features    string    `db:"features" json:"features"`
	Price       float64   `db:"price" json:"price"`
	Stock       int       `db:"stock" json:"stock"`
	Quantity    int       `db:"quantity" json:"quantity"`
	AddedAt     time.Time `db:"added_at" json:"-"`
}

package models

import "time"

type Product struct {
	ProductID   int       `db:"product_id" json:"product_id"`
	ImageURL    string    `db:"image_url" json:"image_url"`
	Name        string    `db:"name" json:"name"`
	Description string    `db:"description" json:"description"`
	Features    string    `db:"features" json:"features"`
	Price       float64   `db:"price" json:"price"`
	Stock       int       `db:"stock" json:"stock"`
	CreatedAt   time.Time `db:"created_at" json:"-"`
}

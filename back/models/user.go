package models

import "time"

type User struct {
	UserID      int       `db:"user_id" json:"user_id"`
	UserName    string    `db:"username" json:"username"`
	Email       string    `db:"email" json:"email"`
	PhoneNumber string    `db:"phone_number" json:"phone"`
	Password    string    `db:"password" json:"password"`
	ImageURL    string    `db:"image_url" json:"image_url"`
	CreatedAt   time.Time `db:"created_at" json:"-"`
}

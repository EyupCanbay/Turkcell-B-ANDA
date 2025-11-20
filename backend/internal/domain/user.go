package domain

import (
	"time"
	"gorm.io/gorm"
)

type User struct {
	ID         uint           `gorm:"primaryKey"`
	Name       string         `gorm:"not null"`
	Email      string         `gorm:"unique;not null"`
	Password   string         `gorm:"not null"`
	City       string         `gorm:"size:50"`
	University string         `gorm:"size:100"`
	SkillLevel string         `gorm:"size:20"`
	CreatedAt  time.Time
	DeletedAt  gorm.DeletedAt `gorm:"index"` // Soft Delete Sihri
}

type RegisterRequest struct {
	Name     string `json:"name" validate:"required"`
	Email    string `json:"email" validate:"required,email"`
	Password string `json:"password" validate:"required,min=6"`
}

type LoginRequest struct {
	Email    string `json:"email" validate:"required,email"`
	Password string `json:"password" validate:"required"`
}

type UpdateProfileRequest struct {
	City       string `json:"city" validate:"required"`
	University string `json:"university" validate:"required"`
	SkillLevel string `json:"skill_level" validate:"required"`
}

type UserResponse struct {
	ID    uint   `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
	City  string `json:"city"`
}

type UserRepository interface {
	Create(user *User) error
	FindByEmail(email string) (*User, error)
	FindByID(id uint) (*User, error)
	Update(user *User) error
	Delete(id uint) error 
}

type AuthService interface {
	Register(req *RegisterRequest) error
	Login(req *LoginRequest) (string, error) 
}

type UserService interface {
	GetProfile(userID uint) (*UserResponse, error)
	UpdateProfile(userID uint, req *UpdateProfileRequest) error
	DeleteUser(userID uint) error
}
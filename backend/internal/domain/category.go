package domain

import (
	"time"
	"gorm.io/gorm"
)

type Category struct {
	ID          uint           `gorm:"primaryKey"`
	Name        string         `gorm:"unique;not null;size:100"`
	Description string         `gorm:"type:text"`
	CreatedAt   time.Time
	DeletedAt   gorm.DeletedAt `gorm:"index"` // Soft Delete
}

type CreateCategoryRequest struct {
	Name        string `json:"name" validate:"required"`
	Description string `json:"description"`
}

type UpdateCategoryRequest struct {
	Name        string `json:"name"`
	Description string `json:"description"`
}

type CategoryResponse struct {
	ID          uint   `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
}

type CategoryRepository interface {
	Create(category *Category) error
	FindAll() ([]Category, error)
	FindByID(id uint) (*Category, error)
	Update(category *Category) error
	Delete(id uint) error
}

type CategoryService interface {
	CreateCategory(req *CreateCategoryRequest) error
	GetAllCategories() ([]CategoryResponse, error)
	GetCategoryByID(id uint) (*CategoryResponse, error)
	UpdateCategory(id uint, req *UpdateCategoryRequest) error
	DeleteCategory(id uint) error
}
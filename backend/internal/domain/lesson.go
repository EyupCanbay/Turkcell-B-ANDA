package domain

import (
	"time"
	"gorm.io/gorm"
)

type Lesson struct {
	ID          uint           `gorm:"primaryKey"`
	CategoryID  uint           `gorm:"not null;index"` // Foreign Key
	Category    Category       `gorm:"foreignKey:CategoryID"` // İlişki Tanımı
	Title       string         `gorm:"not null;size:150"`
	VideoURL    string         `gorm:"type:text"`
	DurationMin int            `gorm:"check:duration_min > 0"`
	Difficulty  string         `gorm:"size:20;check:difficulty IN ('Easy', 'Medium', 'Hard')"`
	CreatedAt   time.Time
	DeletedAt   gorm.DeletedAt `gorm:"index"`
}

type CreateLessonRequest struct {
	CategoryID  uint   `json:"category_id" validate:"required"`
	Title       string `json:"title" validate:"required"`
	VideoURL    string `json:"video_url"`
	DurationMin int    `json:"duration_min" validate:"gt=0"`
	Difficulty  string `json:"difficulty" validate:"oneof=Easy Medium Hard"`
}

type UpdateLessonRequest struct {
	Title       string `json:"title"`
	VideoURL    string `json:"video_url"`
	DurationMin int    `json:"duration_min"`
	Difficulty  string `json:"difficulty"`
}

type LessonResponse struct {
	ID           uint   `json:"id"`
	CategoryID   uint   `json:"category_id"`
	CategoryName string `json:"category_name,omitempty"` // İlişkili veri
	Title        string `json:"title"`
	VideoURL     string `json:"video_url"`
	DurationMin  int    `json:"duration_min"`
	Difficulty   string `json:"difficulty"`
}

type LessonRepository interface {
	Create(lesson *Lesson) error
	FindAll() ([]Lesson, error)
	FindByID(id uint) (*Lesson, error)
	FindByCategory(categoryID uint) ([]Lesson, error)
	Update(lesson *Lesson) error
	Delete(id uint) error
}

type LessonService interface {
	CreateLesson(req *CreateLessonRequest) error
	GetAllLessons() ([]LessonResponse, error)
	GetLessonByID(id uint) (*LessonResponse, error)
	GetLessonsByCategory(categoryID uint) ([]LessonResponse, error)
	UpdateLesson(id uint, req *UpdateLessonRequest) error
	DeleteLesson(id uint) error
}
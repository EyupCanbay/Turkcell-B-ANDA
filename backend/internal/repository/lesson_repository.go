package repository

import (
	"skillhub-backend/internal/domain"
	"gorm.io/gorm"
)

type lessonRepository struct {
	db *gorm.DB
}

func NewLessonRepository(db *gorm.DB) domain.LessonRepository {
	return &lessonRepository{db: db}
}

func (r *lessonRepository) Create(lesson *domain.Lesson) error {
	return r.db.Create(lesson).Error
}

func (r *lessonRepository) FindAll() ([]domain.Lesson, error) {
	var lessons []domain.Lesson
	// Preload: Dersi getirirken Kategori detayını da içine doldur (JOIN mantığı)
	err := r.db.Preload("Category").Find(&lessons).Error
	return lessons, err
}

func (r *lessonRepository) FindByID(id uint) (*domain.Lesson, error) {
	var lesson domain.Lesson
	err := r.db.Preload("Category").First(&lesson, id).Error
	return &lesson, err
}

func (r *lessonRepository) FindByCategory(categoryID uint) ([]domain.Lesson, error) {
	var lessons []domain.Lesson
	err := r.db.Preload("Category").Where("category_id = ?", categoryID).Find(&lessons).Error
	return lessons, err
}

func (r *lessonRepository) Update(lesson *domain.Lesson) error {
	return r.db.Save(lesson).Error
}

func (r *lessonRepository) Delete(id uint) error {
	return r.db.Delete(&domain.Lesson{}, id).Error
}
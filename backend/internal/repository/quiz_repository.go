package repository

import (
	"skillhub-backend/internal/domain"
	"gorm.io/gorm"
)

type quizRepository struct {
	db *gorm.DB
}

func NewQuizRepository(db *gorm.DB) domain.QuizRepository {
	return &quizRepository{db: db}
}

func (r *quizRepository) CreateQuestion(question *domain.QuizQuestion) error {
	return r.db.Create(question).Error
}

func (r *quizRepository) GetQuestionsByLessonID(lessonID uint) ([]domain.QuizQuestion, error) {
	var questions []domain.QuizQuestion
	err := r.db.Where("lesson_id = ?", lessonID).Find(&questions).Error
	return questions, err
}

func (r *quizRepository) CreateResult(result *domain.QuizResult) error {
	return r.db.Create(result).Error
}
package domain

import (
	"time"
	"gorm.io/gorm"
)

type QuizQuestion struct {
	ID            uint              `gorm:"primaryKey"`
	LessonID      uint              `gorm:"not null;index"`
	QuestionText  string            `gorm:"not null"`
	CorrectAnswer string            `gorm:"not null"`             
	Options       map[string]string `gorm:"serializer:json;not null"` 
	CreatedAt     time.Time
	DeletedAt     gorm.DeletedAt    `gorm:"index"`
}

type QuizResult struct {
	ID          uint           `gorm:"primaryKey"`
	UserID      uint           `gorm:"not null"`
	LessonID    uint           `gorm:"not null"`
	Score       int            `gorm:"check:score >= 0 AND score <= 100"`
	CompletedAt time.Time      `gorm:"autoCreateTime"`
	DeletedAt   gorm.DeletedAt `gorm:"index"`
}


type CreateQuestionRequest struct {
	LessonID      uint              `json:"lesson_id" validate:"required"`
	QuestionText  string            `json:"question_text" validate:"required"`
	CorrectAnswer string            `json:"correct_answer" validate:"required"`
	Options       map[string]string `json:"options" validate:"required"`
}

type SubmitQuizRequest struct {
	Answers map[uint]string `json:"answers" validate:"required"`
}

type QuizResultResponse struct {
	Score          int    `json:"score"`
	CorrectCount   int    `json:"correct_count"`
	TotalQuestions int    `json:"total_questions"`
	Message        string `json:"message"`
}


type QuizRepository interface {
	CreateQuestion(question *QuizQuestion) error
	GetQuestionsByLessonID(lessonID uint) ([]QuizQuestion, error)
	CreateResult(result *QuizResult) error
}

type QuizService interface {
	AddQuestion(req *CreateQuestionRequest) error
	GetQuestions(lessonID uint) ([]QuizQuestion, error)
	SubmitQuiz(userID, lessonID uint, req *SubmitQuizRequest) (*QuizResultResponse, error)
}
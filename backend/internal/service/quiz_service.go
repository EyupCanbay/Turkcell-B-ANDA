package service

import (
	"errors"
	"skillhub-backend/internal/domain"
)

type quizService struct {
	repo domain.QuizRepository
}

func NewQuizService(repo domain.QuizRepository) domain.QuizService {
	return &quizService{repo: repo}
}

func (s *quizService) AddQuestion(req *domain.CreateQuestionRequest) error {
	q := &domain.QuizQuestion{
		LessonID:      req.LessonID,
		QuestionText:  req.QuestionText,
		CorrectAnswer: req.CorrectAnswer,
		Options:       req.Options,
	}
	return s.repo.CreateQuestion(q)
}

func (s *quizService) GetQuestions(lessonID uint) ([]domain.QuizQuestion, error) {
	return s.repo.GetQuestionsByLessonID(lessonID)
}

func (s *quizService) SubmitQuiz(userID, lessonID uint, req *domain.SubmitQuizRequest) (*domain.QuizResultResponse, error) {
	dbQuestions, err := s.repo.GetQuestionsByLessonID(lessonID)
	if err != nil {
		return nil, err
	}
	if len(dbQuestions) == 0 {
		return nil, errors.New("bu ders için tanımlı soru yok")
	}

	correctCount := 0
	totalQuestions := len(dbQuestions)

	for _, q := range dbQuestions {
		userAnswer, exists := req.Answers[q.ID]
		
		if exists && userAnswer == q.CorrectAnswer {
			correctCount++
		}
	}


	score := (correctCount * 100) / totalQuestions

	result := &domain.QuizResult{
		UserID:   userID,
		LessonID: lessonID,
		Score:    score,
	}

	if err := s.repo.CreateResult(result); err != nil {
		return nil, err
	}

	message := "Tebrikler!"
	if score < 50 {
		message = "Konuyu tekrar etmelisin."
	} else if score == 100 {
		message = "Mükemmel! Tam puan."
	}

	return &domain.QuizResultResponse{
		Score:          score,
		CorrectCount:   correctCount,
		TotalQuestions: totalQuestions,
		Message:        message,
	}, nil
}
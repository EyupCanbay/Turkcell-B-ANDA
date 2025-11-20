package service

import (
	"skillhub-backend/internal/domain"
)

type lessonService struct {
	repo domain.LessonRepository
}

func NewLessonService(repo domain.LessonRepository) domain.LessonService {
	return &lessonService{repo: repo}
}

func (s *lessonService) CreateLesson(req *domain.CreateLessonRequest) error {
	lesson := &domain.Lesson{
		CategoryID:  req.CategoryID,
		Title:       req.Title,
		VideoURL:    req.VideoURL,
		DurationMin: req.DurationMin,
		Difficulty:  req.Difficulty,
	}
	return s.repo.Create(lesson)
}

// Ortak Helper: Entity listesini Response listesine çevirir
func mapLessonsToResponse(lessons []domain.Lesson) []domain.LessonResponse {
	var response []domain.LessonResponse
	for _, l := range lessons {
		response = append(response, domain.LessonResponse{
			ID:           l.ID,
			CategoryID:   l.CategoryID,
			CategoryName: l.Category.Name, // Preload sayesinde dolu gelir
			Title:        l.Title,
			VideoURL:     l.VideoURL,
			DurationMin:  l.DurationMin,
			Difficulty:   l.Difficulty,
		})
	}
	return response
}

func (s *lessonService) GetAllLessons() ([]domain.LessonResponse, error) {
	lessons, err := s.repo.FindAll()
	if err != nil {
		return nil, err
	}
	return mapLessonsToResponse(lessons), nil
}

func (s *lessonService) GetLessonsByCategory(categoryID uint) ([]domain.LessonResponse, error) {
	lessons, err := s.repo.FindByCategory(categoryID)
	if err != nil {
		return nil, err
	}
	return mapLessonsToResponse(lessons), nil
}

func (s *lessonService) GetLessonByID(id uint) (*domain.LessonResponse, error) {
	l, err := s.repo.FindByID(id)
	if err != nil {
		return nil, err
	}
	return &domain.LessonResponse{
		ID:           l.ID,
		CategoryID:   l.CategoryID,
		CategoryName: l.Category.Name,
		Title:        l.Title,
		VideoURL:     l.VideoURL,
		DurationMin:  l.DurationMin,
		Difficulty:   l.Difficulty,
	}, nil
}

func (s *lessonService) UpdateLesson(id uint, req *domain.UpdateLessonRequest) error {
	lesson, err := s.repo.FindByID(id)
	if err != nil {
		return err
	}

	if req.Title != "" { lesson.Title = req.Title }
	if req.VideoURL != "" { lesson.VideoURL = req.VideoURL }
	if req.DurationMin > 0 { lesson.DurationMin = req.DurationMin }
	if req.Difficulty != "" { lesson.Difficulty = req.Difficulty }

	return s.repo.Update(lesson)
}

func (s *lessonService) DeleteLesson(id uint) error {
	return s.repo.Delete(id)
}
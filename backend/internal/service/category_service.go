package service

import (
	"skillhub-backend/internal/domain"
)

type categoryService struct {
	repo domain.CategoryRepository
}

func NewCategoryService(repo domain.CategoryRepository) domain.CategoryService {
	return &categoryService{repo: repo}
}

func (s *categoryService) CreateCategory(req *domain.CreateCategoryRequest) error {
	category := &domain.Category{
		Name:        req.Name,
		Description: req.Description,
	}
	return s.repo.Create(category)
}

func (s *categoryService) GetAllCategories() ([]domain.CategoryResponse, error) {
	categories, err := s.repo.FindAll()
	if err != nil {
		return nil, err
	}

	var response []domain.CategoryResponse
	for _, cat := range categories {
		response = append(response, domain.CategoryResponse{
			ID:          cat.ID,
			Name:        cat.Name,
			Description: cat.Description,
		})
	}
	return response, nil
}

func (s *categoryService) GetCategoryByID(id uint) (*domain.CategoryResponse, error) {
	cat, err := s.repo.FindByID(id)
	if err != nil {
		return nil, err
	}
	return &domain.CategoryResponse{
		ID:          cat.ID,
		Name:        cat.Name,
		Description: cat.Description,
	}, nil
}

func (s *categoryService) UpdateCategory(id uint, req *domain.UpdateCategoryRequest) error {
	cat, err := s.repo.FindByID(id)
	if err != nil {
		return err
	}

	if req.Name != "" {
		cat.Name = req.Name
	}
	if req.Description != "" {
		cat.Description = req.Description
	}

	return s.repo.Update(cat)
}

func (s *categoryService) DeleteCategory(id uint) error {
	return s.repo.Delete(id)
}
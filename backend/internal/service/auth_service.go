package service

import (
	"errors"
	"skillhub-backend/internal/domain"
	"skillhub-backend/pkg/utils" 

	"golang.org/x/crypto/bcrypt"
)

type authService struct {
	repo domain.UserRepository
}

func NewAuthService(repo domain.UserRepository) domain.AuthService {
	return &authService{repo: repo}
}

func (s *authService) Register(req *domain.RegisterRequest) error {
	if _, err := s.repo.FindByEmail(req.Email); err == nil {
		return errors.New("bu email zaten kullanımda")
	}

	hashedPass, _ := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	defaultSkill := "beginner"
	user := &domain.User{
		Name:       req.Name,
		Email:      req.Email,
		Password:   string(hashedPass),
		SkillLevel: defaultSkill,
	}

	return s.repo.Create(user)
}

func (s *authService) Login(req *domain.LoginRequest) (string, error) {
	user, err := s.repo.FindByEmail(req.Email)
	if err != nil {
		return "", errors.New("kullanıcı bulunamadı")
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		return "", errors.New("hatalı şifre")
	}

	token, err := utils.GenerateJWT(user.ID)
	return token, err
}

package domain

// Entity (Veritabanı Tablosu)
type Leaderboard struct {
	ID          uint   `gorm:"primaryKey"`
	UserID      uint   `gorm:"not null;unique"`
	User        User   `gorm:"foreignKey:UserID"` // İlişki: Kullanıcı adını çekmek için
	Rank        int    `gorm:"default:0"`
	TotalPoints int    `gorm:"not null"`
	City        string `gorm:"size:50"`
}

// DTO (Frontend'e Gidecek Veri)
type LeaderboardResponse struct {
	Rank        int    `json:"rank"`
	UserID      uint   `json:"user_id"`
	Name        string `json:"name"`        // User tablosundan gelecek
	TotalPoints int    `json:"total_points"`
	City        string `json:"city"`
	BadgeCount  int    `json:"badge_count"` // User tablosundan gelecek
}

// Interface'ler
type LeaderboardRepository interface {
	GetTopUsers(limit int, city string) ([]Leaderboard, error)
}

type LeaderboardService interface {
	GetLeaderboard(limit int, city string) ([]LeaderboardResponse, error)
}
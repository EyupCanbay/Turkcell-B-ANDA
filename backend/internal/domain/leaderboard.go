package domain

// Leaderboard Entity (Veritabanı Tablosu)
type Leaderboard struct {
	ID uint `gorm:"primaryKey"`

	// DİKKAT: Aşağıdaki 2 satır Preload("User") için ZORUNLUDUR!
	UserID uint `gorm:"not null;unique"`
	User   User `gorm:"foreignKey:UserID;references:ID"`

	Rank        int    `gorm:"default:0"`
	TotalPoints int    `gorm:"not null"`
	City        string `gorm:"size:50"`
}

// LeaderboardResponse (Frontend'e Giden Veri)
type LeaderboardResponse struct {
	Rank        int    `json:"rank"`
	UserID      uint   `json:"user_id"`
	Name        string `json:"name"`
	TotalPoints int    `json:"total_points"`
	City        string `json:"city"`
	BadgeCount  int    `json:"badge_count"`
}

// Interface'ler
type LeaderboardRepository interface {
	GetTopUsers(limit int, city string) ([]Leaderboard, error)
}

type LeaderboardService interface {
	GetLeaderboard(limit int, city string) ([]LeaderboardResponse, error)
}

// ... (LeaderboardResponse struct'ın burada) ...

// --- AŞAĞIDAKİ KODU EN ALTA EKLE ---

// TableName: GORM'un tabloyu "leaderboards" yerine "leaderboard" olarak aramasını sağlar.
func (Leaderboard) TableName() string {
	return "leaderboard"
}

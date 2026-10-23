PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS reports (
  id TEXT PRIMARY KEY,
  reference_code TEXT NOT NULL UNIQUE,
  type TEXT NOT NULL CHECK (type IN ('lost','found')),
  category TEXT NOT NULL CHECK (category IN ('Documents','Téléphones et appareils','Clés et accessoires','Véhicules','Animaux','Personnes disparues','Autre')),
  title TEXT NOT NULL CHECK (length(title) BETWEEN 4 AND 100),
  city TEXT NOT NULL CHECK (length(city) BETWEEN 2 AND 80),
  event_date TEXT NOT NULL,
  description TEXT NOT NULL CHECK (length(description) BETWEEN 10 AND 1200),
  image_key TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','published','hidden','resolved')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_reports_public_created ON reports(status, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_reports_match ON reports(status, type, category, city, event_date);
CREATE TABLE IF NOT EXISTS feedback (
  id TEXT PRIMARY KEY,
  reference_code TEXT NOT NULL UNIQUE,
  category TEXT NOT NULL CHECK (category IN ('suggestion','bug','publication','usability','safety','other')),
  message TEXT NOT NULL CHECK (length(message) BETWEEN 5 AND 2000),
  publication_received TEXT NOT NULL CHECK (publication_received IN ('not_applicable','yes','no')),
  report_reference TEXT,
  contact_email TEXT,
  page_url TEXT,
  status TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new','reviewed','closed')),
  created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_feedback_status_created ON feedback(status, created_at DESC);

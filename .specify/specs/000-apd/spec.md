<!--
GENERATED FILE — DO NOT EDIT.
SSOT: /Spec.md
Run: powershell -ExecutionPolicy Bypass -File scripts/sync-spec.ps1
-->
# SpecDock - 時給換算・適正単価算出アプリ 仕様書

**バージョン**: 1.0.0  
**最終更新日**: 2026/01/04  
**SSOT（Single Source of Truth）**

---

## 1. プロダクト概要

### 1.1 プロダクト名
**SpecDock**（スペックドック）

### 1.2 コンセプト
「あなたの時間、正しく値付けできていますか？」

フリーランス・副業ワーカーが自分の作業時間から適正な単価を逆算し、案件の価値を可視化できるWebアプリケーション。生成AIを活用した副業・フリーランス支援ツールとして、@Makhmeto_AI のフォロワー（副業志望の20代を中心とした層）に向けて提供する。

### 1.3 解決する課題

- フリーランス・副業初心者が適正単価を把握できていない
- 時給換算せずに安い案件を受けてしまう
- 作業時間の記録・可視化ができていない
- 案件の収益性を比較検討できない

### 1.4 ターゲットユーザー

**プライマリ**: 副業志望の20代男女（@Makhmeto_AI フォロワー層）
- 本業を持ちながら副業を検討・実践中
- 生成AIツールに興味がある
- 収益化・効率化に関心が高い
- スマホでの利用が中心

**セカンダリ**: フリーランスエンジニア・デザイナー・ライター
- 案件管理・単価管理をしたい人
- クライアントへの見積もり根拠を示したい人

---

## 2. 機能要件

### 2.1 コア機能

#### 2.1.1 時給換算計算機
- 案件報酬 ÷ 作業時間 = 実質時給を自動計算
- 目標時給との比較表示
- 入力項目:
  - 案件名（任意）
  - 報酬金額（円）
  - 見積もり作業時間（時間 or 分）
  - 実績作業時間（タイマー連動可）

#### 2.1.2 適正単価逆算機能
- 目標時給 × 作業時間 = 適正報酬額を算出
- 複数パターンのシミュレーション
- 入力項目:
  - 目標時給（円/時間）
  - 想定作業時間
  - 経費（オプション）
  - 税金・手数料（オプション）

#### 2.1.3 作業時間トラッカー
- ストップウォッチ形式のタイマー
- 一時停止・再開機能
- 日ごと・週ごと・月ごとの集計
- カテゴリ別の時間管理（案件別、タスク別）

#### 2.1.4 案件管理ダッシュボード
- 進行中・完了済み案件の一覧
- 収益性ランキング（時給順）
- 月間収益グラフ
- 目標達成率の可視化

### 2.2 サブスクリプション機能（Stripe課金）

#### 2.2.1 無料プラン（Free）
- 案件登録: 3件まで
- 時給計算機能: 無制限
- 月間レポート: 直近1ヶ月のみ
- 広告表示あり

#### 2.2.2 スタンダードプラン（Pro）: ¥480/月
- 案件登録: 無制限
- 月間・年間レポート
- データエクスポート（CSV）
- 広告非表示
- 優先サポート

#### 2.2.3 プレミアムプラン（Business）: ¥980/月
- Pro機能すべて
- 複数クライアント管理
- 請求書テンプレート生成
- 年間分析レポート
- API連携（将来予定）

### 2.3 認証・ユーザー管理

- メールアドレス＋パスワードによるサインアップ/ログイン
- Googleアカウント連携（OAuth2.0）
- パスワードリセット機能
- プロフィール編集（目標時給設定など）
- アカウント削除機能

### 2.4 UI/UX要件

- モバイルファースト設計（レスポンシブ対応）
- ダークモード対応
- PWA対応（ホーム画面追加可能）
- オフライン時の基本操作対応（タイマー等）
- 日本語UI（固有名詞・技術用語は英語可）

---

## 3. 非機能要件

### 3.1 パフォーマンス
- ページ読み込み: 3秒以内
- API応答時間: 500ms以内（95パーセンタイル）
- 同時接続数: 1,000ユーザー対応

### 3.2 セキュリティ
- HTTPS必須
- JWT認証（アクセストークン＋リフレッシュトークン）
- パスワードハッシュ化（bcrypt）
- CORS設定（許可オリジン限定）
- SQLインジェクション対策（Pydantic + SQLAlchemy ORM）
- XSS対策（React標準エスケープ＋DOMPurify）
- レート制限（100リクエスト/分/IP）

### 3.3 可用性
- 稼働率目標: 99.5%
- 定期バックアップ（日次）
- エラー監視・通知

### 3.4 スケーラビリティ
- 水平スケーリング対応のアーキテクチャ
- Docker Compose → 将来的にKubernetes移行可能な設計

---

## 4. 技術スタック（確定事項）

### 4.1 フロントエンド

| 項目 | 技術 | バージョン | 理由 |
|------|------|-----------|------|
| フレームワーク | React | 18.x | 豊富なエコシステム、開発者プールの広さ |
| 言語 | TypeScript | 5.x | 型安全性、開発体験向上 |
| ビルドツール | Vite | 5.x | 高速なHMR、軽量 |
| スタイリング | Tailwind CSS | 3.x | ユーティリティファースト、高速開発 |
| UIコンポーネント | shadcn/ui | 最新 | カスタマイズ性、アクセシビリティ |
| 状態管理 | Zustand | 4.x | シンプル、軽量、TypeScript親和性 |
| HTTP通信 | TanStack Query | 5.x | キャッシュ、再フェッチ、オフライン対応 |
| フォーム | React Hook Form + Zod | 最新 | バリデーション、パフォーマンス |
| ルーティング | React Router | 6.x | 標準的なルーティング |
| グラフ | Recharts | 2.x | React親和性、カスタマイズ性 |
| PWA | Vite PWA Plugin | 最新 | オフライン対応、インストール可能 |

### 4.2 バックエンド

| 項目 | 技術 | バージョン | 理由 |
|------|------|-----------|------|
| フレームワーク | FastAPI | 0.109+ | 高速、型安全、自動ドキュメント生成 |
| 言語 | Python | 3.11+ | FastAPIとの親和性、asyncio対応 |
| ASGI サーバー | Uvicorn | 0.27+ | 高パフォーマンス |
| ORM | SQLAlchemy | 2.x | 非同期対応、成熟したエコシステム |
| バリデーション | Pydantic | 2.x | FastAPI標準、型安全 |
| 認証 | python-jose + passlib | 最新 | JWT生成・検証、パスワードハッシュ |
| マイグレーション | Alembic | 1.x | SQLAlchemy連携 |
| タスクキュー | Celery + Redis（将来） | - | 非同期処理（メール送信等） |

### 4.3 データベース

| 項目 | 技術 | 理由 |
|------|------|------|
| メインDB | PostgreSQL 15+ | 信頼性、JSON対応、拡張性 |
| キャッシュ | Redis | セッション管理、レート制限 |

### 4.4 インフラ・デプロイ

| 項目 | 技術 | 理由 |
|------|------|------|
| コンテナ | Docker + Docker Compose | 環境統一、再現性 |
| ホスティング（初期） | Railway or Render | 低コスト、自動デプロイ |
| ホスティング（将来） | AWS (ECS or EKS) | スケーラビリティ |
| CDN | Cloudflare | パフォーマンス、セキュリティ |
| ドメイン | Cloudflare or Route53 | DNS管理 |

### 4.5 決済

| 項目 | 技術 | 理由 |
|------|------|------|
| 決済プラットフォーム | Stripe | 必須要件、日本対応、豊富なAPI |
| サブスクリプション | Stripe Billing | 定期課金管理 |
| 決済UI | Stripe Checkout / Elements | セキュリティ、UX |
| Webhook | Stripe Webhooks | 決済イベント連携 |

### 4.6 監視・ログ

| 項目 | 技術 | 理由 |
|------|------|------|
| エラー監視 | Sentry | リアルタイムエラー追跡 |
| ログ管理 | Logfire or CloudWatch | 集約・分析 |
| APM | 将来的にDatadog検討 | パフォーマンス監視 |

### 4.7 開発ツール

| 項目 | 技術 |
|------|------|
| バージョン管理 | Git + GitHub |
| CI/CD | GitHub Actions |
| コード品質 | ESLint, Prettier, Ruff, mypy |
| テスト（FE） | Vitest + React Testing Library |
| テスト（BE） | pytest + pytest-asyncio |
| API仕様 | OpenAPI (FastAPI自動生成) |
| 型生成 | openapi-typescript |

---

## 5. データモデル（ER図概要）

### 5.1 主要エンティティ

```
User
├── id: UUID (PK)
├── email: String (UNIQUE)
├── hashed_password: String
├── display_name: String
├── target_hourly_rate: Integer (目標時給)
├── stripe_customer_id: String
├── subscription_plan: Enum (FREE, PRO, BUSINESS)
├── subscription_status: Enum (ACTIVE, CANCELED, PAST_DUE)
├── google_id: String (nullable)
├── created_at: DateTime
├── updated_at: DateTime
└── Projects[] (1:N)

Project (案件)
├── id: UUID (PK)
├── user_id: UUID (FK → User)
├── name: String
├── client_name: String (nullable)
├── status: Enum (DRAFT, IN_PROGRESS, COMPLETED, ARCHIVED)
├── budget: Integer (報酬額)
├── estimated_hours: Float (見積もり時間)
├── actual_hours: Float (実績時間)
├── hourly_rate: Float (計算された時給)
├── deadline: Date (nullable)
├── notes: Text (nullable)
├── created_at: DateTime
├── updated_at: DateTime
└── TimeLogs[] (1:N)

TimeLog (作業ログ)
├── id: UUID (PK)
├── project_id: UUID (FK → Project)
├── started_at: DateTime
├── ended_at: DateTime (nullable)
├── duration_minutes: Integer
├── description: String (nullable)
├── created_at: DateTime
└── updated_at: DateTime

Subscription (Stripe連携)
├── id: UUID (PK)
├── user_id: UUID (FK → User)
├── stripe_subscription_id: String
├── stripe_price_id: String
├── status: String
├── current_period_start: DateTime
├── current_period_end: DateTime
├── cancel_at_period_end: Boolean
├── created_at: DateTime
└── updated_at: DateTime
```

---

## 6. API設計（主要エンドポイント）

### 6.1 認証

| メソッド | パス | 説明 |
|----------|------|------|
| POST | /api/v1/auth/register | 新規ユーザー登録 |
| POST | /api/v1/auth/login | ログイン（JWT発行） |
| POST | /api/v1/auth/refresh | トークンリフレッシュ |
| POST | /api/v1/auth/logout | ログアウト |
| POST | /api/v1/auth/password-reset | パスワードリセット要求 |
| POST | /api/v1/auth/password-reset/confirm | パスワードリセット確定 |
| GET | /api/v1/auth/google | Google OAuth開始 |
| GET | /api/v1/auth/google/callback | Google OAuthコールバック |

### 6.2 ユーザー

| メソッド | パス | 説明 |
|----------|------|------|
| GET | /api/v1/users/me | 現在のユーザー情報取得 |
| PATCH | /api/v1/users/me | プロフィール更新 |
| DELETE | /api/v1/users/me | アカウント削除 |

### 6.3 案件（Projects）

| メソッド | パス | 説明 |
|----------|------|------|
| GET | /api/v1/projects | 案件一覧取得 |
| POST | /api/v1/projects | 案件作成 |
| GET | /api/v1/projects/{id} | 案件詳細取得 |
| PATCH | /api/v1/projects/{id} | 案件更新 |
| DELETE | /api/v1/projects/{id} | 案件削除 |
| GET | /api/v1/projects/{id}/stats | 案件統計取得 |

### 6.4 作業ログ（TimeLogs）

| メソッド | パス | 説明 |
|----------|------|------|
| GET | /api/v1/projects/{id}/timelogs | 作業ログ一覧 |
| POST | /api/v1/projects/{id}/timelogs | 作業ログ作成 |
| POST | /api/v1/projects/{id}/timelogs/start | タイマー開始 |
| POST | /api/v1/projects/{id}/timelogs/{log_id}/stop | タイマー停止 |
| PATCH | /api/v1/timelogs/{id} | 作業ログ更新 |
| DELETE | /api/v1/timelogs/{id} | 作業ログ削除 |

### 6.5 計算ツール

| メソッド | パス | 説明 |
|----------|------|------|
| POST | /api/v1/calculator/hourly-rate | 時給計算（認証不要） |
| POST | /api/v1/calculator/estimate | 適正単価算出（認証不要） |

### 6.6 ダッシュボード

| メソッド | パス | 説明 |
|----------|------|------|
| GET | /api/v1/dashboard/summary | 収益サマリー |
| GET | /api/v1/dashboard/chart/monthly | 月間グラフデータ |
| GET | /api/v1/dashboard/ranking | 収益性ランキング |

### 6.7 Stripe連携

| メソッド | パス | 説明 |
|----------|------|------|
| POST | /api/v1/billing/checkout-session | Checkoutセッション作成 |
| GET | /api/v1/billing/portal-session | カスタマーポータルURL取得 |
| POST | /api/v1/billing/webhook | Stripe Webhook受信 |
| GET | /api/v1/billing/subscription | サブスクリプション状態取得 |

---

## 7. 画面構成

### 7.1 パブリックページ（認証不要）

- `/` - ランディングページ（時給計算機能デモ付き）
- `/login` - ログイン
- `/register` - 新規登録
- `/password-reset` - パスワードリセット
- `/pricing` - 料金プラン

### 7.2 認証済みページ

- `/dashboard` - ダッシュボード（ホーム）
- `/projects` - 案件一覧
- `/projects/new` - 案件作成
- `/projects/{id}` - 案件詳細・タイマー
- `/calculator` - 計算ツール
- `/settings` - 設定・プロフィール
- `/settings/billing` - 課金管理
- `/export` - データエクスポート（Pro以上）

---

## 8. Stripe課金フロー

### 8.1 新規サブスクリプション

1. ユーザーが料金プランを選択
2. フロントエンドがバックエンドに Checkout Session 作成をリクエスト
3. バックエンドが Stripe API で Session 作成、URL を返却
4. フロントエンドが Stripe Checkout にリダイレクト
5. 決済完了後、Stripe が success_url にリダイレクト
6. Stripe Webhook (checkout.session.completed) でバックエンドが処理
7. ユーザーのプラン更新

### 8.2 サブスクリプション管理

- プラン変更: Stripe Customer Portal 経由
- キャンセル: Customer Portal または手動API
- 支払い失敗: Webhook (invoice.payment_failed) で通知

### 8.3 Webhook イベント

| イベント | 処理内容 |
|----------|----------|
| checkout.session.completed | サブスクリプション開始 |
| customer.subscription.updated | プラン変更反映 |
| customer.subscription.deleted | サブスクリプション終了 |
| invoice.payment_succeeded | 支払い成功記録 |
| invoice.payment_failed | 支払い失敗通知 |

---

## 9. セキュリティ設計

### 9.1 認証フロー

```
[ログイン]
1. POST /auth/login (email, password)
2. パスワード検証 (bcrypt.verify)
3. アクセストークン発行 (JWT, 有効期限: 30分)
4. リフレッシュトークン発行 (JWT, 有効期限: 7日, HttpOnly Cookie)
5. レスポンス: { access_token, token_type: "bearer" }

[トークンリフレッシュ]
1. POST /auth/refresh (Cookie: refresh_token)
2. リフレッシュトークン検証
3. 新しいアクセストークン発行
4. レスポンス: { access_token }

[API認証]
1. リクエストヘッダー: Authorization: Bearer {access_token}
2. FastAPI Depends(get_current_user) でトークン検証
3. ユーザー情報をリクエストコンテキストに注入
```

### 9.2 JWTペイロード

```json
{
  "sub": "user_uuid",
  "email": "user@example.com",
  "plan": "PRO",
  "exp": 1704365400,
  "iat": 1704363600
}
```

### 9.3 環境変数（.env）

```env
# Application
APP_ENV=production
SECRET_KEY=<ランダムな256ビット以上の文字列>
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# Database
DATABASE_URL=postgresql+asyncpg://user:pass@host:5432/specdock

# Redis
REDIS_URL=redis://localhost:6379/0

# Stripe
STRIPE_SECRET_KEY=sk_live_xxx
STRIPE_PUBLISHABLE_KEY=pk_live_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx
STRIPE_PRICE_PRO=price_xxx
STRIPE_PRICE_BUSINESS=price_xxx

# Google OAuth
GOOGLE_CLIENT_ID=xxx.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=xxx

# Frontend
FRONTEND_URL=https://specdock.app
CORS_ORIGINS=["https://specdock.app"]

# Sentry
SENTRY_DSN=https://xxx@sentry.io/xxx
```

---

## 10. 開発ロードマップ

### Phase 1: MVP（4週間）
- [ ] プロジェクト初期設定（Docker, CI/CD）
- [ ] 認証機能（メール＋パスワード）
- [ ] 時給計算機能（パブリック）
- [ ] 案件CRUD
- [ ] 基本的なダッシュボード
- [ ] Stripe決済連携

### Phase 2: 機能拡充（3週間）
- [ ] Google OAuth連携
- [ ] 作業タイマー機能
- [ ] 月間レポート
- [ ] CSVエクスポート
- [ ] PWA対応

### Phase 3: 最適化（2週間）
- [ ] パフォーマンスチューニング
- [ ] SEO対策
- [ ] オフライン対応強化
- [ ] エラー監視強化

### Phase 4: 追加機能（継続）
- [ ] 請求書テンプレート
- [ ] 複数クライアント管理
- [ ] API公開（将来）

---

## 11. 運用・保守

### 11.1 バックアップ
- PostgreSQL: 日次スナップショット
- ユーザーデータ: 暗号化バックアップ

### 11.2 監視項目
- エラー率
- レスポンスタイム
- CPU/メモリ使用率
- サブスクリプション解約率

### 11.3 SLA目標
- 稼働率: 99.5%
- データ復旧: 24時間以内

---

## 12. 法的要件

### 12.1 必要ドキュメント
- 利用規約
- プライバシーポリシー
- 特定商取引法に基づく表記

### 12.2 コンプライアンス
- 個人情報保護法への準拠
- Stripeの利用規約遵守
- Cookie同意（GDPR対応検討）

---

## 変更履歴

| 日付 | バージョン | 変更内容 |
|------|------------|----------|
| 2026/01/04 | 1.0.0 | 初版作成 |

---

**作成者**: @Makhmeto_AI プロジェクト  
**承認者**: -


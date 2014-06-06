Students::Application.routes.draw do
  root to: redirect("/preparation")

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  get "/logout" => "sessions#destroy", :as => "logout"

  get "/preparation" => "public_pages#preparation", as: "preparation"
  get "/calendar" => "public_pages#calendar", as: "calendar"

  namespace :student do
    get "/dashboard" => "dashboard#index"
    get "/info" => "info#index", as: "info"

    resources :questions, only: [:index, :create]

    resources :exercises, only: [:index, :show] do
      resources :submissions, only: [:new, :create]
    end
    resources :feedback_entries, only: [:new, :index, :create, :show]
  end

  resources :students, only: :show

  namespace :instructor do
    get "dashboard" => "dashboard#index"
    resources :exercises do
      resources :comprehension_questions
    end

    resources :cohorts, only: [:index, :show] do
      get :one_on_ones, on: :member

      resources :pairs
      resources :students, only: [:new, :create, :show]
      resources :cohort_exercises
      resources :feedback_entries, only: [:new, :index, :create, :show]

      get "/attendance" => "attendance#new", as: :attendance
      post "/attendance" => "attendance#create"
    end
  end


  get "/personal_information" => "personal_information#edit", as: :personal_information
  patch "/personal_information" => "personal_information#update"


  resources :job_opportunities

  namespace :assessments do
    resources :quiz_templates do
      post :create_quizzes_for_cohort, on: :member
      post :create_quiz_for_user, on: :member
    end
    resources :quizzes do
      post :submit, on: :member
    end
    get "/quiz_grades/:cohort_id/:quiz_template_id" => "quiz_grades#summary", as: "quiz_grades_summary"
    get "/quiz_grades/:cohort_id/:quiz_template_id/:question_index" => "quiz_grades#question", as: "quiz_grades_question"
    post "/quiz_grades/:cohort_id/:quiz_template_id/:question_index" => "quiz_grades#grade_question"
  end

  namespace :clicker do
    get "/" => "location#new"
    get "/:location" => "role#new", as: :new_role
    get "/:location/instructor" => "instructor#show", as: :instructor
    get "/:location/instructor/boot" => "instructor#boot"
    post "/:location/instructor/reset" => "instructor#reset"
    get "/:location/student" => "student#show", as: :student
    post "/:location/student/you-lost-me" => "student#you_lost_me"
    post "/:location/student/caught-up" => "student#caught_up"
  end
end

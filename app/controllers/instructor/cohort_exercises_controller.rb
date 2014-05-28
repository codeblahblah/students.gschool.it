class Instructor::CohortExercisesController < InstructorRequiredController
  def index
    @cohort = Cohort.find(params[:cohort_id])
    @exercises = @cohort.exercises
  end

  def show
    @exercise = CohortExercise.includes(:exercise).find_by!(cohort_id: params[:cohort_id])
    @submissions = @exercise.submissions
    @students_missing_submission = @exercise.students_missing_submission
  end

  def new
    @cohort = Cohort.find(params[:cohort_id])
  end

  def create
    @cohort_exercise = CohortExercise.new(create_params)

    if @cohort_exercise.save
      redirect_to instructor_cohort_cohort_exercises_path, notice: 'Exercise successfully added to cohort'
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:cohort_exercise).
      permit(:exercise_id).
      merge(cohort_id: params[:cohort_id])
  end
end
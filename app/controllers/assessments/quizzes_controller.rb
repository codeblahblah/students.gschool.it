module Assessments
  class QuizzesController < SignInRequiredController

    def show
      @quiz = Quiz.find(params[:id])
    end

    def edit
      @quiz = Quiz.find(params[:id])
      raise 'Access Denied' unless @quiz.status == Quiz::UNSUBMITTED
    end

    def update
      @quiz = Quiz.find(params[:id])
      params[:quiz][:answers].each do |id, text|
        answer = @quiz.answers.find(id)
        answer.text = text
        answer.save!
      end
      redirect_to assessments_quiz_path(@quiz)
    end

    def submit
      @quiz = Quiz.find(params[:id])
      @quiz.status = Assessments::Quiz::SUBMITTED
      @quiz.save!
      redirect_to assessments_quiz_path(@quiz)
    end

  end
end
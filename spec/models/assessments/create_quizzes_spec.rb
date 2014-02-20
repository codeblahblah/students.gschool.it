require 'spec_helper'

module Assessments
  describe 'CreateQuizzes' do

    describe ".call" do
      it "creates quizzes for every user in the given cohort" do
        quiz_template = QuizTemplate.create!(name: 'Ruby', question_text: "who is bob\nwho is nate")
        cohort = Cohort.create!(name: 'g2')
        user1 = create_user(first_name: 'first', last_name: 'last', email: 'first@example.com', cohort: cohort)
        user2 = create_user(first_name: 'second', last_name: 'last', email: 'second@example.com', cohort: cohort)
        create_user(first_name: 'third', last_name: 'last', email: 'third@example.com', cohort: Cohort.create!(name: 'foo'))

        expect {
          expect {
            CreateQuizzes.call(quiz_template, cohort)
          }.to change { Quiz.count }.by(2)
        }.to change { QuizAnswer.count }.by(4)
        
        quiz1 = Quiz.find_by(user_id: user1)
        expect(quiz1.status).to eq(Quiz::UNSUBMITTED)
        expect(quiz1.answers.map(&:question)).to match_array(['who is bob', 'who is nate'])
        expect(quiz1.answers.map(&:user)).to match_array([user1, user1])
        
        quiz2 = Quiz.find_by(user_id: user2)
        expect(quiz2.status).to eq(Quiz::UNSUBMITTED)
        expect(quiz2.answers.map(&:question)).to match_array(['who is bob', 'who is nate'])
        expect(quiz2.answers.map(&:user)).to match_array([user2, user2])
      end
    end

  end
end
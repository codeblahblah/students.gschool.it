module ObjectFactories

  def create_instructor_user(overrides = {})
    create_user(overrides).tap do |u|
      u.add_role(User::INSTRUCTOR)
      u.save!
    end
  end

  def create_user(overrides = {})
    new_user(overrides).tap do |u|
      u.save!
    end
  end

  def new_user(overrides = {})
    defaults = {
        email: "user#{rand}@example.com",
        first_name: 'John',
        last_name: 'Smith',
        cohort: new_cohort
    }
    User.new(defaults.merge(overrides))
  end

  def create_question(overrides = {})
    new_question(overrides).tap do |u|
      u.save!
    end
  end

  def new_question(overrides = {})
    defaults = {
      text: "Some text"
    }
    
    Question.new(defaults.merge(overrides))
  end

  def create_feedback_entry(overrides = {})
    new_feedback_entry(overrides).tap do |fe|
      fe.save!
    end
  end

  def new_feedback_entry(overrides = {})
    defaults = {
      comment: "Great job!"
    }
    FeedbackEntry.new(defaults.merge(overrides))
  end

  def create_cohort(overrides = {})
    new_cohort(overrides).tap do |c|
      c.save!
    end
  end

  def new_cohort(overrides = {})
    defaults = {
        name: "gSchool#{rand(1000)}",
        directions: "<p>Some directions</p>",
        google_maps_location: 'https://google.com',
        start_date: "01/01/2001",
        end_date: "06/01/2001"
    }
    Cohort.new(defaults.merge(overrides))
  end

  def create_exercise(overrides = {})
    new_exercise(overrides).tap do |a|
      a.save!
    end
  end

  def new_exercise(overrides = {})
    defaults = {
      name: 'Arrays and stuff',
      github_repo: 'http://example.com'
    }

    Exercise.new(defaults.merge(overrides))
  end

  def new_submission(overrides = {})
    defaults = {
      github_repo_name: 'repo'
    }

    Submission.new(defaults.merge(overrides))
  end

  def create_submission(overrides = {})
    new_submission(overrides).tap do |s|
      s.save!
    end
  end

  def new_company(overrides = {})
    defaults = {
      name: 'Pivotal Labs',
      contact_name: 'Mike',
      contact_email: 'mike@example.com'
    }
    Company.new(defaults.merge(overrides))
  end

  def create_company(overrides = {})
    new_company(overrides).tap do |c|
      c.save!
    end
  end

  def create_job_opportunity(overrides = {})
    new_job_opportunity(overrides).tap do |m|
      m.save!
    end
  end

  def new_job_opportunity(overrides = {})
    defaults = {
      company: new_company,
      location: 'Denver, CO',
      application_due_date: '07/20/2014',
      user: new_user
    }
    JobOpportunity.new(defaults.merge(overrides))
  end
end

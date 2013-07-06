module ObjectCreationMethods

  def create_submission(overrides = {})
    defaults = {
      title: "Valid Band Title", 
      body: "Valid Band Bio",
      twitter: "seainhd",
      email: "example@example.com"
    }
    Submission.create!(defaults.merge(overrides))
  end
end

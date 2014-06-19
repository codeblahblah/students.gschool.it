class ModifyJobOpportunities < ActiveRecord::Migration
  def change
    remove_column :job_opportunities, :company_name
    remove_column :job_opportunities, :contact_name
    remove_column :job_opportunities, :contact_email
    remove_column :job_opportunities, :contact_number
    rename_column :job_opportunities, :company_location, :location
    add_column :job_opportunities, :company_id, :integer
  end
end

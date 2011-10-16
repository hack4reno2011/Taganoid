module Setting::StatusesHelper
  
  def delete_status(status)
    link_to('Delete', 
            setting_status_path(status[:id]), 
            {:method => :delete,
             :confirm => "Are you sure you want to delete #{status[:name]}?"})
  end
  
end

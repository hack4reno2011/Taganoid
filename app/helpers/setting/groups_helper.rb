module Setting::GroupsHelper
  
  def delete_group(group)
    link_to('Delete', 
            setting_group_path(group[:id]), 
            {:method => :delete,
             :confirm => "Are you sure you want to delete #{group[:name]}?"})
  end
  
end

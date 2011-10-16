module Setting::EntryTypesHelper
  
  def delete_entry_type(entry_type)
    link_to('Delete', 
            setting_entry_type_path(entry_type[:id]), 
            {:method => :delete,
             :confirm => "Are you sure you want to delete #{entry_type[:name]}?"})
  end
  
end

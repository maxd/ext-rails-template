module Admin::UsersHelper

  def user_table
    collection_table(@users, :class => 'app-table app-admin-users-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :login, t('.login')
      t.header.column :email, t('.email')
      t.header.column :last_login_ip, t('.last_login_ip')
      t.header.column :last_login_at, t('.last_login_at')
      t.header.column :created_at, t('.created_at')
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = "There are no users"
      t.rows.each do |row, item, index|
        last_login_at = item.last_login_at ? I18n.l(item.last_login_at.localtime, :format => "%e %B %Y") : "-"

        row.login item.login
        row.email item.email
        row.last_login_ip item.last_login_ip || "-"
        row.last_login_at last_login_at 
        row.created_at I18n.l(item.created_at.localtime, :format => "%e %B %Y")
        row.actions user_table_actions(item)
      end
    end
  end

  def user_table_actions(item)
    edit_url = edit_admin_user_path(item)
    delete_url = admin_user_path(item)

    parts = []
    parts << link_to(image_tag("edit.png"), edit_url)
    parts << "&nbsp;"
    parts << link_to(image_tag("delete.png"), delete_url, :method => "delete", :class => "delete")
    parts.join("\n")
  end
  
end

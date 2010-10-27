module HelperMethods

  def t(text)
    I18n.t(text)
  end

  def log_in_with(user)
    visit new_session

    fill_the_following(
      "user_email"=> user.email,
      "user_password" => user.password
    )
    click_button "user_submit"
  end

  [:notice, :error, :alert].each do |name|
    define_method "should_have_flash_#{name}" do |message|
      page.should have_css(".#{name}", :text => message)
    end
  end

  def should_be_on(path)
    page.current_url.should match(Regexp.new(path))
  end

  def should_not_be_on(path)
    page.current_url.should_not match(Regexp.new(path))
  end

  def should_have_errors(*messages)
    within(:css, "#error_explanation") do
      messages.each { |msg| page.should have_content(msg) }
    end
  end

  def should_have_ar_errors
    page.should have_css("#error_explanation")
  end

  def fill_the_following(fields={})
    fields.each do |field, value|
      fill_in field, :with => value
    end
  end

  def should_have_the_following(*contents)
    contents.each do |content|
      page.should have_content(content)
    end
  end

  def should_have_table(table_name, *rows)
    within(:xpath, table_name) do
      rows.each do |columns|
        columns.each { |content| page.should have_content(content) }
      end
    end
  end

  def delete_record(pos, table_name)
    within(:xpath, "#{table_name}") do
      within(:xpath, "//tr[@id='#{pos}']") do
        click_link t("destroy")
      end
    end
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance

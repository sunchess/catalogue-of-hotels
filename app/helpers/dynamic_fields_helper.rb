module DynamicFieldsHelper
  def show_draft(field)
    field.draft? ? t('dynamic_fields.draft') : t('dynamic_fields.not_draft')
  end
end

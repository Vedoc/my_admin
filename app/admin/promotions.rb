ActiveAdmin.register Promotion do
  VALID_CAR_NEEDS = ['AAA', 'Insurance Provider', 'Car Manufacturer Program', 'Other'].freeze
  permit_params :first_name, :last_name, :email, :phone_number, :car_needs

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :car_needs
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone_number
      f.input :car_needs, as: :select, collection: VALID_CAR_NEEDS, label: 'Current roadside provider?',
                          prompt: 'Select an option'
    end
    f.actions
  end
end

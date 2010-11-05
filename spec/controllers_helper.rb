def get_show(main_model, mock_store, var)
  main_model.stub(:find).with("37") { mock_store }
  get :show, :id => "37"
  assigns(var).should be(mock_store)
end

def get_new(main_model, mock_store, var)
  main_model.stub(:new) { mock_store }
  get :new
  assigns(var).should be(mock_store)
end

def get_edit(main_model, mock_store, var)
  main_model.stub(:find).with("37") { mock_store }
  get :edit, :id => "37"
  assigns(var).should be(mock_store)
end
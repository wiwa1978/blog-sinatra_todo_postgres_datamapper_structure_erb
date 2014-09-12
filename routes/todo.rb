  get "/?" do
    redirect "/todos"
  end

  get "/todos/?" do
    logger.debug "Calling the index page-Wim"
    @todos = Todo.all(:order => :created_at.desc)
    erb :"todo/index"
  end
   
  # Get the New Post form
  get "/todos/new/?" do
    logger.info "Creating new todo item"
    @title = "New To Do"
    erb :"/todo/new"
  end


  # The New Post form sends a POST request (storing data) here
  # where we try to create the post it sent in its params hash.
  # If successful, redirect to that post. Otherwise, render the "posts/new"
  # template where the @post object will have the incomplete data that the
  # user can modify and resubmit.
  post "/todos/?" do
    logger.info "New todo item created test: " + params[:content]
    todo = Todo.new(:content => params[:content], :created_at => Time.now,:updated_at => Time.now)
    if todo.save
    #Todo.create(:content => params[:content], :created => Time.now)
      flash[:success] = "Message saved successfully."
      redirect '/'
    else 
      flash[:error] = "Something went wrong"
      #redirect '/'
      #todo.errors.each do |error|
      #  puts error
      #end
    end
  end
   

  # Get the individual page of the post with this ID.
  get "/todos/:id/?" do
    #@todo = Todo.first(:id => params[:id])
    @todo = Todo.get(params[:id])
    @title = "test"
    erb :"todo/show"
  end
   
  # Get the Edit Post form of the post with this ID.
  get "/todos/edit/:id/?" do
    #@todo = Todo.first(:id => params[:id])
    @todo = Todo.get(params[:id])
    @title = "Edit Form"
    erb :"todo/edit"
  end
   
  # The Edit Post form sends a PUT request (modifying data) here.
  # If the post is updated successfully, redirect to it. Otherwise,
  # render the edit form again with the failed @post object still in memory
  # so they can retry.
  put "/todos/:id/?" do
    todo = Todo.get(params[:id])
    #todo.completed_at = params[:done] ?  Time.now : nil
    #make a note about dirty resources
    #todo.update(:content => params[:content], :done => params[:done], :completed_at => params[:done] ?  Time.now : nil)
    logger.info "Edit: " + params[:content].to_s
    logger.info "Edit: " + params[:done].to_s

    todo.update(:content => params[:content], :done => params[:done], :completed_at => params[:done] ?  Time.now : nil)
    redirect "/todos"
    
  end
   
  get '/todos/delete/:id/?' do
    @todo = Todo.get(params[:id])
    erb :"todo/delete"
  end


  delete '/todos/delete/:id/?' do
    Todo.get(params[:id]).destroy
    redirect '/'  
  end

 
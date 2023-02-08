class ImportPostsJob < ApplicationJob
  queue_as :default

  def perform(import_id)
    import = Import.find(import_id)

    sleep rand(2)

    import.processing!

    sleep rand(3)

    Post.create!(title: 'Fkat', body: 'A nobis aut blanditi' * rand(4))
    Post.create!(title: "Fugiat dolorem magn #{rand(100)}", body: 'A nobis aut blanditi')
    Post.create!(title: "Fugiat dolorem magn #{rand(100)}", body: 'A nobis aut blanditi')
    Post.create!(title: "Fugiat dolorem magn #{rand(100)}", body: 'A nobis aut blanditi')

    sleep rand(2)

    import.completed!
  rescue StandardError
    import.error!
  end
end

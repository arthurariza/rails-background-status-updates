class ImportPostsJob < ApplicationJob
  queue_as :default

  def perform(import_id)
    import = Import.find(import_id)

    sleep 5

    import.processing!

    import.broadcast_replace_later_to 'imports', partial: 'imports/import', target: "import_#{import.id}"

    sleep 10

    Post.create(title: "Fugiat dolorem magn #{rand(100)}", body: 'A nobis aut blanditi' * rand(4))
    Post.create(title: "Fugiat dolorem magn #{rand(100)}", body: 'A nobis aut blanditi' * rand(4))
    Post.create(title: "Fugiat dolorem magn #{rand(100)}", body: 'A nobis aut blanditi' * rand(4))

    sleep 5

    import.completed!

    import.broadcast_replace_later_to 'imports', partial: 'imports/import', target: "import_#{import.id}"
  rescue StandardError
    import.error!
    import.broadcast_replace_later_to 'imports', partial: 'imports/import', target: "import_#{import.id}"
  end
end

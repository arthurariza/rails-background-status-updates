module ImportsHelper
  def status_class(status)
    {
      'queued' => 'bg-info',
      'processing' => 'bg-warning',
      'completed' => 'bg-success',
      'error' => 'bg-danger'
    }[status]
  end
end

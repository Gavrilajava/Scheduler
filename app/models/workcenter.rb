class Workcenter < ApplicationRecord

  has_many :jobs

  validates :code, format: { with: /\A[0-9]{3}\z/, message: "should consist of three digits" }

  scope :sorted, -> {order(:code)}
  scope :groups, -> {distinct.pluck(:group)}
  scope :get_for_group, -> (group){where(group: group).order(:code).pluck(:code)}


  def get_jobs
    self.jobs.includes(:production).order(:sequence)
  end

  def menu
    {
      groups: Workcenter.groups,
      workcenters: Workcenter.get_for_group(self.group)
    }
  end

  def set_start_date
    date = self.get_jobs.first.start
    date ? date : date = Time.now
    self.update(start_date: date)
  end

  def calculate
    jobs = self.jobs.order(:sequence)
    update_array = []
    jobs.each_with_index do |job, index|
      record = {id: job.id, created_at: Time.now, updated_at: Time.now}
      record[:sequence] = 10 * (index + 1)
      if index == 0
        record[:start] = self.start_date
      elsif job.fixed_date && job.fixed_date > update_array[index -1][:end]
        record[:start] = job.fixed_date
      else
        record[:start] = update_array[index -1][:end]
      end
      setup = job.setup ? job.setup : 0
      quantity = job.split_quantity - (job.produced ? job.produced : 0)
      record[:end] = record[:start] + (setup + (quantity / (job.performance / 60))).minutes
      update_array << record
    end
    Job.import(update_array, on_duplicate_key_update: [:sequence, :start, :end], validate: false, timestamps: false)
  end



end


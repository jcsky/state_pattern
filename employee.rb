class Employee
  attr_reader :state, :hp

  def initialize(state: state)
    @state = state
    @hp    = init_hp
  end

  def tickets_attack(atk)
    @hp = EmployeeType.atk_scale(state, @hp, atk)
    update_state!
  end

  def take_break
    @hp = EmployeeType.take_break(state, @hp)
    update_state!
  end

  private

  def update_state!
    @state = if hp > 100
               :super
             elsif hp.between?(61, 100)
               :normal
             elsif hp.between?(31, 60)
               :warning
             elsif hp.between?(1, 30)
               :dying
             elsif hp <= 0
               :game_over
             end
  end

  def init_hp
    if state == :super
      120
    elsif state == :normal
      100
    elsif state == :warning
      60
    elsif state == :dying
      30
    elsif state == :game_over
      0
    end
  end

  class EmployeeType
    def self.atk_scale(state, hp, atk)
      if state == :super
        hp -= atk * 0.6
      elsif state == :normal
        hp -= atk * 0.8
      elsif state == :warning
        hp -= atk * 1
      elsif state == :dying
        hp -= atk * 1.5
      elsif state == :game_over
        hp
      end
    end

    def self.take_break(state, hp)
      if state == :super
         hp -= 10
      elsif state == :normal
         hp += 10
      elsif state == :warning
         hp += 40
      elsif state == :dying
         hp *= 2
      elsif state == :game_over
         hp
      end
    end
  end
end

module Steps
  class CacheStepController < StepController
    private

    def decision_tree_class
      C100App::CacheDecisionTree
    end
  end
end

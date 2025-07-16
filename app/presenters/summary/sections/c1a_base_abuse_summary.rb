module Summary
  module Sections
    class C1aBaseAbuseSummary < BaseSectionPresenter
      ABUSE_LIST = [
        AbuseType::PHYSICAL,
        AbuseType::EMOTIONAL,
        AbuseType::PSYCHOLOGICAL,
        AbuseType::SEXUAL,
        AbuseType::FINANCIAL,
      ].freeze
      def answers
        answers_hash = answer_per_type_and_subject
        [
          Answer.new(:c1a_abuse_physical,      answers_hash[AbuseType::PHYSICAL.value]),
          Answer.new(:c1a_abuse_emotional,     answers_hash[AbuseType::EMOTIONAL.value]),
          Answer.new(:c1a_abuse_psychological, answers_hash[AbuseType::PSYCHOLOGICAL.value]),
          Answer.new(:c1a_abuse_sexual,        answers_hash[AbuseType::SEXUAL.value]),
          Answer.new(:c1a_abuse_financial,     answers_hash[AbuseType::FINANCIAL.value]),
        ]
      end

      private

      def answer_per_type_and_subject
        answers_hash = {}
        result = c100.abuse_concerns.where(subject: subject, kind: ABUSE_LIST)&.to_h { |ac| [ac.kind, ac.answer] }

        ABUSE_LIST.each do |kind|
          answer = result&.key?(kind) ? result[kind] : default_value
          answers_hash[kind.value] = answer
        end

        answers_hash
      end

      def default_value
        GenericYesNo::NO
      end
    end
  end
end

module ClaimData
	extend ActiveSupport::Concern
	class_methods do
		# def pending_claims_f(start_date = nil, end_date = nil)
		# 	query = start_date && end_date ? where( Hash[ (has_attribute?(:ack_date) ? "ack_date" : "claim_date").to_sym, start_date..end_date]) : where(nil)
		# 	datas = query.where(amount_status:nil, claim_status: "0").map { |rec| [rec.claim_amount.to_f - rec.ws_settle_amount.to_f, 0].max }.reject(&:blank?)
		# 	return {count: datas.length, amount: datas.sum}
		# end

		# def setteld_claims(start_date = nil, end_date = nil)
		# 	query = start_date && end_date ? where( Hash[ (has_attribute?(:ack_date) ? "ack_date" : "claim_date").to_sym, start_date..end_date]) : where(nil)
		# 	datas = query.where(amount_status:nil, claim_status: "0").where.not(ws_settle_amount: "").map { |rec| rec.claim_amount.to_f if rec.ws_settle_amount.to_f >= rec.claim_amount.to_f }.reject(&:blank?)
		# 	return {count: datas.length, amount: datas.sum}
		# end

		def pending_claims(start_date = nil, end_date = nil)
			puts "===============start_date ===#{start_date}"
			puts "===============end_date ===#{end_date}"
			puts "===============T/F ===#{start_date && end_date ? 'True' : 'False'}"

			query = start_date && end_date ? where( Hash[ (has_attribute?(:ack_date) ? "ack_date" : "claim_date").to_sym, start_date..end_date]) : where(nil)

			puts "===============total_records ===#{query.count}"
			zero_paid_datas = query.where(amount_status:nil, claim_status: [nil, "0"]).where(ws_settle_amount:["", nil])
			zero_paid = zero_paid_datas.pluck("count(id), sum(claim_amount::float)").first
			puts "===============zero_paid total_records ===#{zero_paid_datas.class}"
			datas = query.where(amount_status:nil, claim_status: "0").where.not(ws_settle_amount: "").where('ws_settle_amount::float < claim_amount::float')
			puts "===============pending_records ===#{(datas + zero_paid_datas).count}"
			data = self.where(id: zero_paid_datas.pluck(:id) + datas.pluck(:id))
			count_and_sum = datas.pluck('count(id), sum(claim_amount::float), sum(ws_settle_amount::float)').first
			return {count: count_and_sum[0] + zero_paid[0], amount: ((count_and_sum[1].to_f + zero_paid[1].to_f).to_f - count_and_sum[2].to_f).to_f.round(2), datas: data}
			puts "============================================================================"
		end

		def setteld_claims(start_date = nil, end_date = nil)
			query = start_date && end_date ? where( Hash[ (has_attribute?(:ack_date) ? "ack_date" : "claim_date").to_sym, start_date..end_date]) : where(nil)
			datas = query.where(amount_status:nil, claim_status: "0").where.not(ws_settle_amount: "").where('ws_settle_amount::float >= claim_amount::float')
			count_and_sum = datas.pluck('count(id), sum(claim_amount::float)').first
			return {count: count_and_sum[0].to_f, amount: count_and_sum[1].to_f.round(2), datas: datas}
		end
  	end
end

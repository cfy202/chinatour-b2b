package com.chinatour.entity;

import java.math.BigDecimal;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 3, 2014 2:09:06 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode
public class OrderReceiveItem extends BaseUuidEntity {
    
	@JsonProperty
	private String receivableInfoOfOrderId; //关联表ReceivableInfoOfOrder的ID
	
	@JsonProperty
	private Integer type; //《团== 1：常规团费 2：其他费用 3：特殊折扣》《非团 == 1:visa 2:flight ticket 3:hotel 4:ticket 5:insurance 6:busTour 7:cruise 8:other    
	
	@JsonProperty
	private BigDecimal itemFee; //费用
	
	@JsonProperty
	private Integer itemFeeNum; //数量
	
	@JsonProperty
	private String remark; //备注
	
	@JsonProperty
	private Integer num; //顺序
	
	@JsonProperty
	private Integer orderType; //用来判断对应订单是团还是非团
	
	@JsonProperty
	private String optionalId; //自选项Id
	
	@JsonProperty
	private TourInfoForOrder tourInfoForOrder;
	
	@JsonProperty
	private String customerId; //自选项Id
	
	@JsonProperty
	private String customerName;
	
}

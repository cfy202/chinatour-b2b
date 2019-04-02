package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;
import java.util.List;

/**
 * Created by Aries on 2016/3/17.
 * B2B费用明细表，辅助表
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class OrderFeeItems extends BaseUuidEntity {
	
    private String orderFeeItemsId;
    private String feeTitle;//费用的标题
    private Integer num;//固定排序（1.adult;2.Children with Bed;3.Children without Bed:,4.Infant;5.小费;6.自费;7.Adult Comm;8.Child Comm;9.Single Supp;10.Pre/Post-Stay;11.Pick/Send）
    private BigDecimal price;//费用
    private Integer pax;//人数
    private String  orderId;//OrderId
  
}

package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.BusinessFlow;

@Data
@EqualsAndHashCode(callSuper = false)
public class BusinessFlowVO {
	private List<BusinessFlow> businessFlowList;
	
	private BusinessFlow businessFlow;
}

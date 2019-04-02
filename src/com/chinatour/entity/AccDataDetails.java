package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @ClassName AccDataDetails
 * @PackageName com.chinatour.entity
 * @Description TODO
 * @author Bowden
 * @Date 2015-11-9 上午11:45:31
 * @Version V1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AccDataDetails extends BaseUuidEntity {

    @JsonProperty
    private String accDataId;
    
    @JsonProperty
    private Date date;
  
    @JsonProperty
    private String type;
    
    @JsonProperty
    private String no;
    
    @JsonProperty
    private String name;
    
    @JsonProperty
    private String account;
    
    @JsonProperty
    private String split;
   
    @JsonProperty
    private String memo;
    
    @JsonProperty
    private Integer qty;
   
    @JsonProperty
    private BigDecimal rate;
    
    @JsonProperty
    private BigDecimal amount;
    
    @JsonProperty
    private String officeSubjectId;
    
    @JsonProperty
    private String userId;
    
    @JsonProperty
    private String companyId;
    
    @JsonProperty
    private String description;
    
    @JsonProperty
    private String serviceItems;
    
    @JsonProperty
    private String accDataDetailsCol3;
    
    @JsonProperty
    private String accDataDetailsCol4;
    
    @JsonProperty
    private String accDataDetailsCol5;
}

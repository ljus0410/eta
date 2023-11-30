package kr.pe.eta.service.pay;

import kr.pe.eta.domain.Pay;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PayDao {

    public void addPay(Pay pay) throws Exception;

}

package com.bjsxt.shopping.product;

public class tester {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(ProductMgr.getInstance().getProductsDisplayOrder());
		System.out.println(ProductMgr.getInstance().getProductIdsIndisplayorder());
		//ProductMgr.getInstance().setProductDisplayOrderById(-1, 1);
		//System.out.println(ProductMgr.getInstance().updateProductDisplayOrders("23,22,24,25,27,28,29,30,31,32,33,34"));
		
	}

}

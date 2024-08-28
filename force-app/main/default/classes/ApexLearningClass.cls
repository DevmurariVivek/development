public with sharing class ApexLearningClass {
    
        static final Double ragularprice = 0.1;
        static Double finalprice = 0;

        public static Double calculateprize(Integer price){
            finalprice= price - price*ragularprice;
            return finalprice;
        }
    
}
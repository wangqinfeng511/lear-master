##### auto #####
​	自推导类型。

##### {} 一致性初始化.
​	<font color=orange>窄化：精度降低或造成数值变的。比如：int x1(5.3) 隐式转换并窄化，舍弃小数部分。int x1{5.3} 是错误的，不会隐式转换。</font>

#####  std::initializer_list<>  用于支持以一系列值(a list of values)进行初始化。

```c++
	 void print(std::initializer_list<int> vals){
			for auto i:vals{
				std::cout<<*i<<std::endl;
		}} 
```

##### explicit 修饰符:
​	禁止隐式转换。

##### for 循环：for(auto &_pos:list):
​	<font color=orange>等价于迭代器：</font>

```c++
	for(auto _pos=list.begin();_pos=list.end();++_pos);
```

##### move 搬迁语义:
​	<font color=red> 作用：用以避免非必要拷贝和临时对象。</font>
​	<font color=orange>string 的move构造函数只是将即有的内部字符数组，赋予给新对象。而非建立一个新array	然后复制所有元素。</font>
​	<font color=red>注：你必须保证搬迁对象在析构后存在。例如把对象的值设置为nullptr。</font>

```c++
	public:
		X(const X& lvalue){
					//复制函数
				};
				X(X&& lvalue){
					//搬迁函数
					//不应该，有return。
					value=lvalue.value;
				};
			private:
				int value=0;
		} 
```

##### 运算符重载：

```c++
public:
			explicit AB(int dc):a(dc){};
//无参构造函数，支持隐式转换。
			AB(){
        	std::cout<<"调用赋值运算"<<std::endl;
      };
//+号重载：
			AB operator +(AB &dc) {
			   AB acx;
			   acx.a=dc.a+a;
			   std::cout<<"+号重载"<<std::endl;
			   return  acx;
			}
//左位移动重载。
			friend std::ostream & operator <<( std::ostream &os,AB &ac){
				os<<ac.a;
				return os;
			}
//copy函数重载。
			AB operator =( AB& dc){
				return *this;
			}
//大于号重载。
			bool  operator >(  const AB &ao){
				   return  (ao.a>a);
			}
//小于号重载。
			bool  operator <(  const AB &ao){
				   std::cout<<ao.a<<"小于"<<a<<std::endl;
				   return  (ao.a<a);
			}
	private:
		int a=10;
	};
	int main(){
		AB dc=AB(24);
		AB adc= dc+dc;
	   std::cout<<"adc"<<adc<<"dc"<<dc<<std::endl;
	} 
```

##### 字符常量：

```c++
  u8"adsf"
	u"sdafadsf"
	U"sadfasdf"
	L"sadfaf"
```

##### noexcept 用于指明某个函数无法---或不打算---抛出异常。

​		<font color=orange>noexcept(bool) 如果符合条件就不抛出异常。默认值是true;</font>
​		<font color=orange>swap函数，move函数应该被标志为带条件的noexcept.</font>
​		<font color=orange>任何析构函数都不应该抛出异常。</font>

##### 崭新的Template特性：

​	<font color=orange>得以接受个数不确定的template参数。</font>

###### 	 模版别名：

```c++
		template <typename T>
		using Vec=std::Vector<T,MyAlloc<T>>
		Vce<int> coll; 等价于：std::vector<int,MyAlloc<int>> coll;
```

######     模版参数默认值：

```c++
	template<typename T,typename T2=int>
```

###### 	 Member template 作用对象复制时给予隐式类型转换。

```c++
	template<typename T>
		class MyClase{
			public:
				template<typename U>
				MyClass(const MyClass<U> &x);
			}
```

##### Lambda:

```c++
[=](int a)->int {}
```

​	<font color=orange>->表示返回类型</font>

​	<font color=orange>[]表示可访问哪些外部变量；</font>

​	<font color=orange>= 意味作用域以 by value 方式传递给lambda,你可以去读取所有数据，但是不能改变它。</font>

​	<font color=orange>& 意味作用域以 by reference方式传递给lambda。可以读可以写。</font>

```c++
	[&]			//全部可读可写
	[=] 		//全部可读
	[x,&y]  //x可读，y可读可写。
```



##### 带领域的 enum

```c++
enum class test: char{mr,ms,co,none};
```

##### 异常类：

​	<font color=red>注意：最好只使用标准异常类。</font>

###### 	Logic Error 逻辑差错异常：

​		<font color=orange>invalid_argument 表示无效实参</font>
​		<font color=orange>length_error 指出某个行为“可能超越最大容许大小”。</font>
​		<font color=orange>out_of_range 指出实参值“不在预期范围内”。</font>
​		<font color=orange>domain_error 指处领域范畴(domain)内的错误。</font>

###### 	Runtime Error 运行时期错误。

​		<font color=orange>range_error 指内部计算时发生区间错误。</font>
​		<font color=orange>overflow_error 指算术运算发生上溢，例如：biset 被转换成一个整数值。</font>
​		<font color=orange>underflow_error 指算术运算发生下溢。</font>
​		<font color=orange>system_error 指因底层操作系统发生的差错。</font>
​		<font color=orange>bad_alloc	new 失败时报错。</font>
​		<font color=orange>bad_weak_ptr	根据一个shared pointer 创建出一个 weak pointer	操作失败。</font>
​		<font color=orange> bad_function_call 	</font>

###### 	成员函数：

```c++
what() //返回错误的string内容。
```

###### 	传递异常：

```c++
//	exception_ptr:
	exception_ptr eptr;
		try{
			throw std::out_of_range("out_of_range( somwhere,somehow)");
			//throw 			    std::system_error(std::make_error_code(std::errc::invalid_argument),"erron disption")
			//system_error第一个参数是错误码。
		}
		catch(const std::out_of_range &e){
			std::cout<<e.what()<<std::endl;
		}catch(system_error){
			std::cout<<e.code()<<std::endl;
			std::cout<<e.name()<<std::endl;
			std::cout<<e.value<<std::endl;
			std::cout<<e.message()<<std::endl;

	}catch(...){
			eptr=std::current_exception() //把异常暂存不处理。
	}
	//执行处理异常
	if(eptr!=nullptr){
		std::rethrow_exception(eptr);
	}


```

##### Pair

```c++
	pair<T1,T2>p
	pair<T1,T2>p(val1,val2);
	p.first
	p.second
	get<0>(p)
	get<1>(p)
	make_pair(std::move(val1),std::move(val2))
	//俩pair对象内的所有元素都相等时才想等。 否则优先第一元素判断。
```

##### Tuple

​	<font color=tan>拥有任意数量的元素</font>

```c++
		tuple<T1,T2,T3,......> t
		swap(t1,t2)	//交换
		make_tuple(std::ref(t1),std::ref(t2),std::ref(t3)); // make一个 tuple
		get<0>(t1)	// 取t1第0个元素的值。
		tie(t1,t2) t;//相当于tuple<T1,T2>(std::ref(t1),std::ref(t2)) t;
		std::tie(t1,std::ignore,t2) //取出t1的值修改成t2 
		tuple_size<t>::size; //元素个数
		tuple_element<index,t>::type //返回地index的元素类型。
		tuple_cat(t1,t2) //将多个tuple串联成一个tuple.
```

​		<font color=red>只有采用std::ref()的参数才能修改。</font>

##### 智能指针：

​	<font color=red>作用：确保"pointer"的寿命 与其指向的对象的寿命一致。</font>

##### 	shared_ptr:

​		<font color=orange>有引用计数的指针。可以像普通指针一样：赋值、拷贝、比较。</font>
​		<font color=orange>支持的方法：</font>

```c++
			shared_ptr<T> sp; #空构造函数
			shared_ptr<T> sp(new T());
			shared_ptr<T> sp(new T(),del)
			reset(sp)		销毁对象以默认销毁方式。
			reset(sp,del) 销毁shared_ptr 以del方式销毁。
			get()	返回内部的指针。
			use_count() 引用次数。
			unique()	是否唯一引用。
			make_shared(...); 创建一个shared_ptr.
			get_deleter(sp) 返回析构对象方法，地址。
		shared_ptr 支持->,* 不支持[]操作。
		make_shared<type>(): 
		//std::string shared_ptr;
```

​			<font color=red>explicit 修饰的构造函数约束它不能接受隐式转换赋值赋值。</font>

​			<font color=teal>错误: </font>

```c++
				shared_ptr<std::string> p=new string("asfdasdf");
```

​			<font color=teal>正确</font>

```c++
				shared_ptr<std::string> p= make_shared<std::string>("adasdfasdf")
```

###### 		shared_ptr处理array类型的数据时，要定义好delete方法:

```c++
			shared_ptr<int> pa(new int[100],[](int *p){
					delete[] p;
			})	
```

​			<font color=orange>取值和设置值。</font>

```c++
				pa.get()[0]=1000;
				std::cout<<pa.get()[0];
```

​	


​			<font color=orange>系统有辅助函数实现销毁：</font>

```c++
				shared_ptr<int>pa(new int[100],std::default_delete<int[]>());
```

###### 		打开的是文件时，析构函数就不能只是释放内存了，还有关闭文件:			

```c++
			Class FileDelete{
					private:
						std::string filename;
					public:
							FileDelete(const std::string &fn):filename(fn){
								fn->close();
								std::remove(filename.c_str());
						}
					}
				shared_ptr<std::ofstream> pf(newstd::ofstream("xx.log"),FileDelete("xx.log"))
```

##### 	weak_ptr: 是shared_ptr的一个工具，

​		<font color=orange>用于解决循环引用不能释放资源的问题。</font>
​		<font color=orange>特点是：在引用是不会影响到内部shared_ptr的计数。</font>
​		<font color=orange>不支持 -> ,* </font>
​		<font color=orange>lock() 返回内部的shared_ptr。</font>
​		<font color=orange>expired() 用于返回资源是否释放，释放true,正常引用false</font>
​		<font color=orange>use_count() 返回内部shared_ptr的引用计数。</font>
​		<font color=orange>reset()	清空weak_ptr;</font>
​		<font color=orange>支持拷贝或赋值不会影响内部的shared_ptr 的引用计数。</font>	

```c++
			class Test{
				public:
					explicit Test(){};
					Test(std::shared_ptr<Test> t);
					int test_value=0;
				private:
				  std::shared_ptr<Test> t;
				};
				int main(){
					std::shared_ptr<Test> as(new Test);
					std::weak_ptr<Test> ccs=as;
					qDebug()<<ccs.expired(); //已经释放, 返回 true; 否则返回 false.
					std::shared_ptr<Test> dx= ccs.lock();
					qDebug()<<dx->test_value;
					dx->test_value=1000;
					std::shared_ptr<Test> dxa=ccs.lock();
					dxa->test_value=10;
					std::shared_ptr<Test> dxb=ccs.lock();
					dxb->test_value=11;
					}
```

##### 	unique_ptr:

​		<font color=orange>unique_ptr被销毁，其指向的对象也一起销毁。</font>
​		<font color=red>unique_ptr指向的对象只有一个拥有者，没有任何俩个unique pointer 以同一个pointer作为初值。</font>
​		<font color=red>unique_ptr不提供 ++指针运算。</font>
​		<font color=red>unique_ptr的值被重复引用时是在运行阶段报错，非编译时报错。</font>

```c++
		#构造函数：
			ptr:代表指针。
			unique_ptr<...> up
			unique_ptr<...> up(nullptr)
			unique_ptr<...> up(ptr)
			unique_ptr<...> up(ptr,del)
			unique_ptr<...> up(std::move(up2));
		 #析构函数。
		 	～unique_ptr();
		 #搬迁函数：
		 	move();
		 #交换函数：
		 	swap(up1,up2)
		# 重置函数：
		 	reset();
		 	reset(ptr);
		 #放弃拥有权
			release() 放弃拥有权。
		 [] array索引操作。
		 ==、！=、<= > >= 
		 删除函数地址：
		 	get_deleter();
		
```

```c++
		 int main(){			
				int *t1=new int(121);
				std::unique_ptr<int> tc(t1);
				qDebug()<<*tc;
				tc.release(); //放弃对t1的拥有权
				std::unique_ptr<int>tca(t1);
				qDebug()<<*tc<<*tca;
     }
```

###### 	unique_ptr array注意:

​		<font color=orange>如：std::unique_ptr\<std::string[]> ts(new std::string[100]);</font>
​		<font color=red>必须明确给出删除销毁的方法,如下：</font>

```c++
		std::unique_ptr<int,void(*)(int *)> pa(new int[10],[](int *p){delete[] p;})
```

​		<font color=orange>std提供的辅助函数来析构列表:</font>

​					<font color=orange>std::default_delete<int[]>() </font>
​	例子文件关闭：

```c++
	#include<dirent.h>
		class DirCloser{
      #关闭文件
			public:
				void operator()(DIR *dp){
					if(closedir(dp)!=0){std::cout<<"关闭文件"<<std::endl;}
				}
		}
		int main(){
			unique_ptr<DIR,DirCloser> pDir(opendir("."));
			struct dirent *dp;
			while((dp=readdir(pDir.get()))!=nullptr){
				string filename(dp->d_name);
				std::cout<<filename<<endl;
			}
			//退出函数时会调用DirClose的().
		}
```


​		
数值的极值：
​	Class numeric_limits<...>
​		is_specialized	类型是否有极值。
​		is_signed		类型带有正负号。
​		is_integer		整数类型。
​		is_exact		计算结果不产生舍/入误差（此成员对所有整数类型而言均为true）;
​		is_bounded		数值集是否有个数限制。
​		is_modulo 
​		is_iec559		iec559 标准。
​		min()			最小值。
​		max()			最大值。
​		lowest()		最大负有限值。
​		digits			正数的位数。
​		digits10		十进制数字个数。
​		max_digits10	必要的十进制数位个数。
​		radix			整数：表述式的底，几乎总是2. 浮点数：指数表达式的底。
​		min_exponent	底radix的最小负数指数。
​		max_exponent	底radix的最大负整数指数。
​		expsilon()		1和最接近1的值之间的差距。
​		round_style		舍/入风格
​		round_error()	最大舍/入误差量度(根据 ISO/IEC 10967-1)
​		has_infinity	类型有“正无穷大” 表述。
​		infinity()		表现“正无穷大”	 （如果有的话）
​		has_quiet_NaN	类型拥有nonsignaling "Not aNumber" 表述。
​		quiet_NaN		安静表达“Not a Number”
​		has_signaling_NaN 类型拥有signaling "Not a Number" 表述形式。
​		signaling_Nan	singnaling "Not a Number" 如果有的话。
​		has_denorm		number of exponent bits;
​		has_denorm_loss loss,而不是一个inexact result
​		denorm_min()	最小正值的 denormalized value
​		traps			已实现trapping
​		tinyness_before	在舍/入(rounding)之间可以侦测出 tinyness;
​		暂不深入学习。
Type Trait:
​	std::true_type 		true	类型 
​	std::false_type 	false	类型。
​	例子：
​		template<typename T>
​		void for_is(const T& val,std::true_type){....}
​		void for_is(const T& val,std::false_type){....}
​		int main(){
​			int a=100;
​			for_is(a,std::is_pointer<int>()); 
​		}
​	std::common_type<T1,T2> 共同性返回。
​		使用方法暂不懂。
​	类型判断工具：
​		is_void<T>				是否void;
​		is_integral<T> 			整数类型(包括bool,char,char16_t、char32_t、wchar_t)
​		is_floating_point<T>	浮点数类型(float,double,long,double);
​		is_arithmetic<T>		整数(包括 bool 和character) 或浮点数类型。
​		is_signed<T>			带正负号的算数类型。
​		is_unsigned<T>			不带正负号的算数类型。
​		is_const<T>				带有const 限定符。
​		is_volatile<T>			带有volatile 限定符。
​		is_array<T>				寻常的array类型(不是 std::array);
​		is_enum<T>				枚举类型
​		is_union<T>				联合（union）类型。
​		is_classs<T>			Class/struct类型，但不是union类型。
​		is_function<T>			函数类型。
​		is_reference<T>			L value / R value reference;
​		is_lvalue_reference<T>	L value reference;
​		is_rvalue_reference<T>	R value	reference;
​		is_pointer<T>			pointer 类型(包括function pointer但不包括pointer to nonstatic member);
​		is_member_pointer<T>	pointer 指向一个nostatic成员。	//待
​		is_member_object_pointer<T> pointer指向一个nostatic数据成员 //  待
​		is_member_function_pointer<T> pointer指向一个nonstatic成员函数。 //待
​		is_fundamental<T>		 void,整数型（包括bool和char）,浮点数，枚举（enumeration）,pointer,member pointer,std::nullptr_t;
​		is_scalar<T>			 整数型（包括bool,character）浮点，枚举，pointer,member pointer;
​		is_object<T>			任何类型，除 void,function,reference
​		is_compound<T>			array,enumeration,union,class,function,reference,pointer;
​		is_trivial<T>			Scalar,trivial class 或哪些类型构成的array;
​		is_trivially_copyable<T> Scalar,trivially copyable class 或那些类型构成的array;
​		is_standard_layout<T>	Scalar,standard layout class 或者那些类型构成的array;
​		is_pod<T>				Plain old data type,"memcpy" 可以用来复制的对象。
​		is_literal_type<T>		Scalar,reference,class 或那些类型构成的array
​	class类型设计
​		is_empty<T>			class不带任何成员，virtual成员函数或virtual base class;
​		is_polymorphic<T>	class带一个virtual成员。
​		is_abstract<T>		Abstract class (至少有一个virtual函数并且这个函数=0)；
​		has_virtual_destructor<T> Class带有virtual的析构函数。
​		is_default_constructible<T>	Class能够完成default construction ,删除默认构造函数是返回false 测试;
​		is_copy_constructible<T>	是否有copy函数。
​		is_move_constructible<T>	是否有move函数。
​		is_copy_assignable<T>		能够完成copy函数。
​		is_move_assignable<T>		能够完成move函数。
​		is_destructible<T>			有可以被调用的析构函数。
​		is_trivially_default_constructible<T>	有能够完成trivial default construction;
​		is_trivially_copy_constructible<T>		没有声明复制构造函数返回true;
​		is_trivially_move_constructible<T>		没有声明搬迁构造函数返回true;
​		is_trivially_copy_assignable<T>			delete 复制函数时返回true;
​		is_trivially_move_assignable<T>			delete 搬迁构造函数时返回true;
​		is_trivially_destructible<T>			没有声明析构函数，或者析构函数是default;
​		is_nothrow_default_constructible<T>		构造函数noexcept (不异常)。
​		is_nothrow_copy_constructible<T>		复制函数noexcept(不异常)
​		is_nothrow_move_constructible<T>		搬迁函数noexcept(不异常)
​		is_nothrow_copy_assignable<T>			struct 的operator=(const C&) noexcept{return *this};  返回true;	
​		is_nothrow_move_assignable<T>			struct 的operator=(const C&&) noexcept{return *this};  返回true;	
​		is_nothrow_destructible<T>				不异常析构函数。
​	检查类型关系：
​		is_same<T1,T2>							T1和T2是相同类型（包括const/volatile 修饰符）；
​		is_base_of<T,D>							类型T是类型D的base class;
​		is_constructible<T,Args...> 			可以用 Args初始化T;
​		is_trivially_constructible<T,Args...>	可运用Args平凡初始化(trivially initialize) T;
​		is_nothrow_constructible<T,Argss...>	用Args初始化T而不抛出异常。
​		is_arrignable<T,T2>						T2可以赋值给T1;
​		is_nothrow_assignable<T,T2>				T2赋值给T1 而不异常；
​		uses_allocator<T,Alloc>					Alloc可被转换为T::allocator_type; //待

辅助函数：
	min(a,b)		最小
	min(a,b,cmp) 	比较a,b以cmp进行：
	min(initlist)	返回list中最小的
	min(initlist,cmp) 返回list中最小的,以cmp进行。
	max(a,b)	最大。
	max(a,b,cmp)	比较a,b以cmp进行：
	max(initlist)	返回list中最大；
	max(initlist,cmp) 返回list中最大，以cmp 进行。
	minmax(a,b) 	返回a-b之间最小最大。
	minmax(a,b,cmp)	 返回a-b之间最小最大，以cmp进行。
	minmax(initlist)
	minmax(initlist,cmp)
	cmp 是一个接受俩参数返回bool的方法：bool int_ptr_less(int *a,int *b){....,retrun true;};
俩值互换：
	std::swap(t2,t2)
	t2和t1有 copy或move;
Class ratio<> 编译期分数运算。
	 ratio<1,10> ; 1/10;
	 xx.num() 分子：
	 xx.den() 分母；
chrono 库：
	duration	时间段；指在某时间单位上的明确片刻数，比如：6分钟为一个时间，那么1小时就是60/6 片刻数就是10；
	timepoint	时间点；一个duration和一个时间epoch(启始点)的组合。
	

std::chrono::duration<参一，ratio<int,int>>，参一表示类型int64_t就行，参二表示单位(一个tick的值)．
		无参：表示1以秒为单位．
			std::ration<60> //一分钟．
			std::ration<1,1000> //毫秒．
	 例：
	   typedef std::chrono::duration<int64_t,std::ratio<60*60*24>> day;
				运算：+,-,*,/,%,==,!=,<,<=,>,++,--;+=,-=,%=
				操作：
						count():返回tick数量．
						zeron():获取长度为0的duration;
						max()
						min()
						period()
				std::chrono::duration_cast<std::chrono::hours>(std::duration cc);转的单位为小时	
		TimePint:时间点：
				#time_point;
						time_point.time_since_epoch()           #从1970_01_01到这个时间点的差．
						std::chrono::system_clock::time_point c; #计算机元年的时间节点
						std::time_t t=std::chrono::system_clock::to_time_t(c); #时间节点转ctime的time_t;
						std::cout<<std::ctime(&t)<<std::endl;           #输出string;
				当前时间：
						std::chrono::system_clock::time_point c;
						c=std::chrono::system_clock::now();
		例：

​				1,      auto cc=std::chrono::system_clock::now();　//获取当前time_point节点．
​					  typedef std::chrono::duration<int64_t,std::ratio<60*60*24>> cx;　//定义一个duration间隔为１天．
​						auto cds= std::chrono::duration_cast<cx>(cc.time_since_epoch());　//转换为以天为分隔的duration
​						qDebug()<<"距离计算机元年1970_01_01："<<cds.count()<<"天";
​				2,
​						std::time_t now=std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
​						struct tm *t=localtime(&now);
​						char date[80];
​						strftime(date,80,"%YYYYd",t);
​						qDebug()<<date;	
 ctime:
​				clock_t 数值类型，表现cpu时间，clock()返回．
​				time_t  数值类型，用来表现timeponint.
​				struct tm 日历时间类型．
​						int tm_sec;     /* seconds after the minute - [0,59] */
​						int tm_min;     /* minutes after the hour - [0,59] */
​						int tm_hour;    /* hours since midnight - [0,23] */
​						int tm_mday;    /* day of the month - [1,31] */
​						int tm_mon;     /* months since January - [0,11] */
​						int tm_year;    /* years since 1900 */
​						int tm_wday;    /* days since Sunday - [0,6] */
​						int tm_yday;    /* days since January 1 - [0,365] */
​						int tm_isdst;   /* daylight savings time flag */
​				clock() 获取cpu时间． 
​				time()  获取当前时间．是个数值．
​				difftime() 获取两个time_t之间的差，是个double值，单位为秒．
​				localtime() 转换time_t为struct tm,按本地时区．
​				gmtime()        转换time_t为struct tm.
​				asctime()       转换tm成为一个字符串．
​				strftime(char *a,int a_size,"ftr",*tr)  转换tm成一个用户自定义字符串．
​						%a 星期几的简写
​						%A 星期几的全称
​						%b 月分的简写
​						%B 月份的全称
​						%c 标准的日期的时间串
​						%C 年份的后两位数字
​						%d 十进制表示的每月的第几天
​						%D 月/天/年
​						%e 在两字符域中，十进制表示的每月的第几天
​						%F 年-月-日
​						%g 年份的后两位数字，使用基于周的年
​						%G 年分，使用基于周的年
​						%h 简写的月份名
​						%H 24小时制的小时
​						%I 12小时制的小时
​						%j 十进制表示的每年的第几天
​						%m 十进制表示的月份
​						%M 十时制表示的分钟数
​						%n 新行符
​						%p 本地的AM或PM的等价显示
​						%r 12小时的时间
​						%R 显示小时和分钟：hh:mm
​						%S 十进制的秒数
​						%t 水平制表符
​						%T 显示时分秒：hh:mm:ss
​						%u 每周的第几天，星期一为第一天 （值从0到6，星期一为0）
​						%U 第年的第几周，把星期日做为第一天（值从0到53）
​						%V 每年的第几周，使用基于周的年
​						%w 十进制表示的星期几（值从0到6，星期天为0）
​						%W 每年的第几周，把星期一做为第一天（值从0到53）
​						%x 标准的日期串
​						%X 标准的时间串
​						%y 不带世纪的十进制年份（值从0到99)
​												%Y 带世纪部分的十进制年份
​						%z，%Z 时区名称，如果不能得到时区名称则返回空字符。
​						%% 百分号
​						例：
​								std::time_t now=std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
​							   struct tm *t=localtime(&now);
​								char date[80];
​								strftime(date,80,"%YYYYd",t);
​								qDebug()<<date;
​				ctime()         转换tm成为一个标准的字符串．
​				mktime()        转换tm为time_t;
​		综合例子：
​				//取出当前时间节点，转换为time_t
​					std::time_t now=std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());　
​				//timet_t转换为tm,包时区．
​				struct tm *t=localtime(&now);　
​				//....格式化输出．．．．后面一样．
​				//      tm转换为time_t;
​				std::time_t now2= mktime(t);
​				//time_t转换为time_point时间节点．
​				std::chrono::system_clock::time_point d= std::chrono::system_clock::from_time_t(now2);
​				//创建一个1000分钟的时间断．
​				std::chrono::duration<int64_t,std::ratio<60,1>> c(1000);
​				//时间节点d减少1000分钟．
​				d-=c;
​				//时间节点转换time_t
​				std::time_t t2= std::chrono::system_clock::to_time_t(d);
​				//时间节点转为tm
​				struct tm *t3 =localtime(&t2);
​				//格式化后的字符串buff;
​				char str_date[80];
​				//格式化字符串
​				std::strftime(str_date,80,"%x",t3);
​				qDebug()<<str_date;

标准模版库：
	容器：
		序列式容器：
			array,vector,deque,list
			vector  特点：可以利用索引访问元素，尾部追加元素，删除元素速度快。中间插入费时，后面元素都向后移动。
					第一次按插元素时会分配2k内存。内存重新分配很耗时；
			deque	特点：俩端追加元素速度快，中间安插元素费时。后面元素统一向后一定。
					push_front();首追加
					push_back(); 尾追加；
			Array	特点：固定元素长度。不可以改变元素个数，只能改变元素值。
			list	特点：任意位置安插或删除速度快。双向链表。不提供随机访问。只能遍历；			
		关联式容器：
			平衡二叉树。
			set,multiset,map,multimap
			set 		集合：元素不可重复；
			multiset	集合：元素可以重复；
			map			字典	:key/value,key不可以重复；
			multimap	字典：key/value,key可以重复；
		无序容器：
			hash桶数据结构
			unordered_set,unordered_multiset,unordered_mulitimap;
			unordered_set 		无序元素集合；
			unordered_multiset	无序可重复元素集合；
			unordered_map		无序map;
			unordered_multimap	无序可重复map;
		特殊容器：
			stack:堆寨容器，后进先出。
				对象方法：push(),top()返回下一个元素,pop() 移除下一个元素，并不返回; 
		all map:
			at(key)获取元素值；元素不存在时报异常：std::out_of_range
		对象函数resize()改变元素空间大小
	区间：
		std::vector<int>::iterator i=find(dc.begin(),dc.end(),134);
    		for(i;i!=dc.end();++i){
			std::cout<<*i<<std::endl;
    		}
    	多重区间：
    		std::vector<int> c{1,2,3},d{12,11,3442,0};
	容器对象属性：
		ContType c				默认空构造
		ContType c(c2)			复制构造
		ContType c=c2			operter={}
		ContType c(rv)			move构造函数
		ContType c=rv;			move构造函数。c=std::move(c2)
		ContType c(beg,end)		区间构造,move迭代器 c(std::make_move_iterator(cc.begin()),std::make_move_iterator(cc.end))
		ContType c(initlist)	
		ContType c=list
		c1==c2
		c1!=c2
		c1<c2
		c1<=c2
		c1>c2
		c1>=c2
		c1.swap(c2) 用于置换俩容器的内容。指针的对调。
		c1.begin();
		c1.end();
		c1.cbegin();
		c1.cend();
		c1.clear();
		c1.empty() 是否为空。
		c1.size()	元素个数
		c1.max_size()	最大元素个数。
		c1.fill(val) 把　val赋值给每个元素。list,
		[index]	索引操作。list
		c1.at(index)	list,
		c1.front()	返回第一个元素。list
		c1.backup()	返回最后一个元素。 list
		c1.capacity()	返回“不重新分配内存情况下”最大元素容量。 vector
		c1.reserve(int number)	元素个数设置。	vector
		c1.shrink_to_fit()	减少元素。 vector;
		c1.assign(n,elem) 复制n个elem元素给 c1 vector;
		c1.insert(pos,elem);  后插入vector费时。
		c1.emplace(pos,elem)	前插入。
		c1.splice(pos,c2)	把c2 move到c1中 list;
		c1.unique() 相邻去重，一般先排序再去重 list
		c1.key_comp() 	返回key比较准则 set,map,mutlset,mutlmap.
		c1.value_comp()	返回value比较准则set,map,mutlset,mutlmap.
		c1.count(val)	返回val个数。	set,map,mutlset,mutlmap.
		c1.find(val)	返回第一个val元素。找不到返回c1.end();,vector无，
		c1.lower_bound(val)	返回<=val的第一元素；set,map,..
		c1.upper_bound(val) 返回>val的第一元素 set,map,
		c1.equal_range(val)	返回==val的第一个元素。set,map
		c1.hash_function()	返回hash函数，无序容器。
		c1.key_eq()			返回“相等判断式” 无序容器。
		c1.bucket_count()	返回桶数，	无序容器。
		c1.max_bucket_count()	返回桶的最大可能数。
		c1.load_factor()	返回当前的负载系数。
		c1.max_load_factor()	返回当前最大负载系数。
		c1.rehash(number)	设置当前桶数最少多少。
		

迭代器：
	begin() 返回迭代器的启始第一个元素。
	end()	返回迭代器的结尾；
		std::vector<int> cd{1,2,3,14,13};
		std::vector<int>::const_iterator pos; 只读元素的临时空间
		std::vector<int>::iterator pos;	可读可写元素临时空间 auto效果一样；
		for(pos=cd.begin();pos!=cd.end();++pos){
			...
		}
	插入型迭代器：
		copy(xx.begin(),xx.end(),back_insert(dd));尾部插入dd容器；
		copy(xx.begin(),xx.end(),front_inserter(dd));首部插入dd容器；
		copy(xx.begin(),xx.end(),insert(dd,int index)) 在指定位置开始插入元素
	串流型迭代器：
		用于读写stream;
		istream_iterator<string>(cin) //流输入迭代器
		ostream_iterator<string>()		//流输出迭代器；
		例子：
			 std::vector<std::string> coll{"asdfasdfasdf","asdfasdfasdf"};
			//   std::copy(std::istream_iterator<std::string>(std::cin), std::istream_iterator<std::string>(),std::back_inserter(coll));
		//   qDebug()<<"输入完";
			std::sort(coll.begin(),coll.end());
			std::unique_copy(coll.begin(),coll.end(),std::ostream_iterator<std::string>(std::cout,"\n"));
算法：
	#include<algorithm>
	查找，排序，拷贝，重新排序，修改，数值运算等基本普遍算法。
	分类方式：
		 非更易型算法：
		 更易型算法：
		 移除算法：
		 变序算法：
		 排序算法：
		 已排序区间算法：
		 数值算法：
	一、非更易型算法：
		for_each(xx.begin(),xx.end(),cmp); cmp是一个函数。可以有返回值。cmp也可以是一个class ,class  operator() 的接受参数实现；
		count(xx.begin(),xx.end(),const T& value);	//返回值的元素数
		count_if(xx.begin(),xx.end(),op);		//统计op为ture的元素数量。op [](int elem){ return elem/4==0}
		min_element(xx.begin(),xx.end(),op) 返回最小元素 op [](int a,int b){return a<b};
		max_element(xx.begin(),xx.end()) 返回最大元素	
		minmas_elment(xbegin(),xx.end())		返回最小最大的元素。	返回pari	
		find(xx.begin(),xx.end(),"abc") 查找元素。返回元素，失败返回 xx.end();
		find_if(xx.begin(),xx.end(),op); 条件查找，cmp是一个lambda, [] (int i){return true/false}
		find_if_not(xx.begin(),xx.end(),op)	 条件不满足。
		search_n(xx.begin(),xx.end(),int count,const T& value,op);	 // 返回连续n个元素都等于value的第一个元素位置。 op  [](int a,int b)->bool {return a==b}
		search(xx.begin(),xx.end(),xx2.begin(),xx2.end(),op)	//返回，查找到的xx区间内完全等于xx2区间的第一个元素。 op [](int a,int b)->bool{return a%1==0}  
																//bool xx2[3]={true,false,true}
		find_end(xx.begin(),xx.end(),xx2.begin(),xx2.end(),op)	//找出xx区间内于xx2区间完全吻合的最后一个区间的第一个元素。
		find_first_of(xx.begin(),xx.end(),xx2.begin(),xx2.end(),op)	//找出xx区间内与xx2区间完全吻合的第一个区间的第一个元素。	
		adjacent_find(xx.beigin(),xx.end(),op)	查找俩相等的元素。
		equal(xx.begin(),xx.end(),xx2.beg(),op)		判断俩区间是否相等。
		is_permutation(xx.begin(),xx.end(),xx2.begin(),op)	俩个不定序区间是否包含相等元素。
		mismatch(xx.begin(),xx.end(),xx.begin(),op)		返回俩序列区间对应元素中不对等元素。
		is_sorted(xx.begin(),xx.end(),op)		区间是否排序。
		is_sorted_until(xx.begin(),xx.end(),op) 返回区间第一个未排序的第一个元素。
		is_partitioned(xx.begin(),xx.end(),op)	返回区间元素是否基于某种准则op分割成俩组,也就是所有符合op条件的元素在前，不符合在后。。
		partition_point(xx.begin(),xx.end(),op) 	
		is_heap(xx.begin(),xx.end(),op)			区间元素是否形成一个heap;
		is_heap_until(xx,begin(),xx.end(),op)		区间元素第一个未遵循heap排序准则的元素。
		all_of(xx.begin(),xx.end(),op)			返回“是否所有元素都吻合某准则”
		any_of(xx.begin(),xx.end(),op)			返回 “是否值少一个元素吻合某准则”
		none_of(xx.begin(),xx.end(),op)			返回“是否无元素吻合某准则”。
		find()				查找某元素出现的位置。
		rfind()				某元素最后一次出现的位置。
	二、更易型算法：
		copy(xx.begin(),xx.end(),xx2.begin())				区间复制；
		copy_if(xx.begin(),xx.end(),xx2.begin(),op)			区间条件复制；
		copy_n(xx.begin(),xx.end(),xx2.begin())				复制n个元素。
		copy_backward(xx.begin(),xx.end(),xx2.begin())		从最后一个元素复制，复制到某个区间。
		move(xx.begin(),xx.end(),xx2.begin())				从第一个元素开始搬迁到某个区间。
		move_backward(xx.begin(),xx.end(),xx.begin())		从最后一个元素移动，复制到某个区间。
		transform(xx.begin(),xx.end(),xx2.begin(),op)			改动（并复制）元素，将俩个区间元素合并。
		merge()				合并俩个区间。
		swap_ranges(xx.begin(),xx.end(),xx.begin())		交换俩个区间的元素。
		fill(xx.begin(),xx.end(),const T& newvalue)				给定值替换所有元素。
		fill_n(xx,begub(),xx.end(),int n,const T& newvalue)			给定值替换前n个元素。
		generate(xx.begin(),xx.end(),op)			以某项(op)操作的结果替换所有元素。
		generate_n(xx.begin(),xx.end(),op)		以某项(op)操作的结果替换n个元素。
		iota(xx.begin(),xx.end(),T startValue)				所有元素以一系列的递增值取代。
		replace(xx.begin(),xx.end(),const T& old value,const T& newvalue)			将某个特定元素替换为另外一个值。
		replace_if(xx,begin(),xx.end(),op,const T& new value)		将符合某准则的元素替换为另一个元素。
		replace_copy(xx.begin(),xx.end(),xx2.begin(),const T& oldValue,const T& new value) ,替换后的保存在新的容器xx2里
		replace_copy_if(xx.begin(),xx.end(),xx2.begin(),op,const T& new value)	按op条件替换xx元素，把结果保存在xx2中。
	三、移除型算法：
		remove(xx.begin(),xx.end(),const T& value)删除某个区间指定值，空间数量不变，返回新终点的位置可用于闭合区间。list不能用。
		remove_if(xx.begin(),xx.end(),op)		"满足某准则"的元素全部删除。
		remove_copy(xx.begin(),xx.end(),xx2.begin(),const T& value)	 "不等于某特定值"的元素全部复制到xx2处
		remove_copy_if(xx.begin(),xx.end(),xx2.begin(),op) "不满足某准则"的元素全部复制到他处
		unique(xx.begin(),xx.end(),op)			移除相临的重复元素
		unique_copy(xx.begin(),xx.end(),op)		移除相临的重复元素，并复制到他处。
	四、变序算法：
		reverse(xx.begin(),xx.end()) 			将元素的次序逆转。
		reverse_copy(xx.begin(),xx.end(),xx2.begin())		复制的同时，逆转元素顺序。
		rotate(xx.begin(),xx.begin()+n,xx.end())			旋转元素次序。 xx.begin()+n 到第一位置，前元素调尾部。
		rotate_copy(xx.begin(),xx.begin()+n,xx.end(),xx2.begin())	旋转元素次序，并复制到容器xx2
		next_permutation(xx.begin(),xx.end(),op)	得到元素的下一个排序次序。 //待
		prev_permutation(xx.begin(),xx.end(),op)	得到元素的上一个排序次序。 //待
		shuffle(xx.begin(),xx.end(), eng)			将元素的顺序随机打乱。eng是随机引xiang数,default_random_engine dre。  class xxx opertor()(xxx max){ return xxxx}
		random_shuffle(xx.begin(),xx.end(),op)	将元素的顺序随机打乱。
		partition(xx.begin(),xx.end(),op)		改变元素次序，使“符合某准则元素” 移到前面。
		stable_partition(xx.begin(),xx.end(),op)	和partition()类似，但保持“与准则相符”和“与准则不符”之各个元素之间相对位置elements.
		partition_copy(xx.begin(),xx.end(),xx2.begin(),xx3.begin(),op)	 把一个区间按规则(op)拆分成俩个子区间。
	五、排序算法：
		sort(xx.begin(),xx.end(),op)	排序。		square()平方运算
		stable_sort(xx.begin(),xx.end(),op)	 排序，对所有元素排序，并保持相等元素之间的相对次序。
		partial_sort(xx.begin(),xx.begin()+3,xx.end())	对前4个元素排序。
		partial_sort_copy(xx.begin(),xx.begin()+3,xx.end(),xx2.begin())	对前4个元素排序。并复制到容器  xx2
		nth_element(xx.begin(),xx.begin()+4,xx.end(),op)	根据第n个位置进行排序。
		make_heap(xx.begin(),xx.end())		将区间转成heap (二叉树)
		xx.push_heap(xx.bgegin(),xx.end()|const T& value)		将元素加入heap
		xx.pop_heap(xx.begin(),xx.end())		从heap移除一个元素。
		sort_heap(xx.begin(),xx.end())		对heap进行排序。
		is_sorted(xx.begin(),xx.end(),op)		检验区间内的元素是否都已排序。
		is_sorted_until(xx.begin(),xx.end(),op)	返回区间内第一个“破坏排序状态”的元素。
		is_partitioned()	检验区间内的元素是否根据某个规则分为俩组。
		is_heap()			检验区间内元素是否都排序成一个heap
		is_heap_until()		返回区间内第一个破坏规则的元素。
	六、已排序区间算法：
		binary_search(xx.begin(),xx.end(),const T& value)		判断某区间内是否包含某元素。
		includes(xx.begin(),xx.end(),xx2.beigin(),xx.end())			判断某区间内的每个元素是否都涵盖于另一个区间。
		lower_bound(xx.begin(),xx.end(),const T & value,op)		查找第一个大于等于某值的元素。
		upper_bound(xx.begin(),xx.end(),const T & value,op)		查找第一个大于某值的元素。
		equal_range(xx.begin(),xx.end(),const T & value,op)		返回 等于某给定值的所有元素构成的区间。  返回为俩元素位置。 
																//pair<xx3<int>::const_iterator,xx3<int>::const_iterator> dc
		merge(xx.begin(),xx.end(),xx2.begin(),xx2.end(),insert(xx3,xx3.begin()),op)				俩区间合并。
		set_union(xx.begin(),xx.end(),xx2.beigin(),xx2.end(),xx3.begin()i,nsert(xx3,xx3.begin()),op)			求俩区间的并集。
		set_intersection(xx.begin(),xx.end(),xx2.beigin(),xx2.end(),xx3.begin(),insert(xx3,xx3.begin()),op)	求俩区间的交集
		set_symmetric_difference(ts.begin(),ts.end(),tss.begin(),tss.end(), std::inserter(tsc,tsc.begin()))	找出俩区间内的元素形成一个已排序区间(不重复的元素，重复的元素丢弃)。 //待
		inplace_meerge(xx.begin(),pos(xx的一个iterator),xx.end()，op) 	从pos位置左移动尾部，右移到开始指针。 
		partition_point()		用一个判断式分割区间，返回分割元素。
		
	七、数值算法：
		accumulate(xx.begin(),xx.end(),value,cmp)	默认是求和，cmp multiplies<int> 乘积，negate<int>() 取反。。。。。结合所有元素（求和，求乘积。。。。）
		inner_product(xx.begin(),xx.end(),xx2.begin(),value,op)	结合俩区间内的所有元素。俩容器的对应元素相乘的总和+value。对应不上时0补齐
		adjacent_difference(xx.begin(),xx.end(),xx2.begin(),op)	将每个元素和其前一元素结合
		partial_sum()	将每个元素和其之前的所有元素结合。
		negate<int>()	取反函数； 
		multiplies<int>() 乘积；

字符串：
	std::string
		=,assign()	赋予新值
		swap()	交换内容
		+=,append(),push_back() 追加字符
		insert()	插入字符
		erase(),pop_back()	删除字符。
		clear()	删除所有字符。
		resize() 改变字符容器长度。在尾部删除或添加字符。
		replace() 替换字符。
		+	拼接字符串
		==,!=,<,<=,>,>=,compare()	比较字符床。
		empty()	判断字符串为空。
		size(),length()	长度
		max_size()		最大长度可能数。
		capacity()		返回重新分配前的字符容量！
		reserve()		保留一定内存容纳字符串。
		shrink_to_fit()	缩减字符串。
		[],at()			访问某个字符。
		front(),back()	第一个，最后一个。
		>>,getline()	输出stream;
		<<				输入stream;
		atoi(),stol(),stoll()	转换整数。
		stoul(),stoull()	不带正负的整数。
		stof(),stod(),stold()	转换浮点数。
		to_string(),to_wstring()	整数/浮点数转为字符串。
		copy()	复制
		data(),c_str()	以char*返回。
		substr()		返回某个字符串。
		begin(),end()....
		get_allocator()	返回分配器。
正则表达式：
	Regex 正则。
		regex reg("<.*>.*<.*>",std::regex_constants::grep) 参数二表示：linux grep命令
	Match:	用正则匹配表达式。
		regex_match(string,reg) //是否整个字符串匹配表达式。
	Search	
		regex_search(string,reg) //是否部分字符串匹配表达式。
	Tokenize:
	Replace:
	

正则语法：
	.		任意一个字符
	[...] 	...字符中的任意一个。
	[^...]	...字符之外的任意一个字符。
	[[:charclass:]]  指定之字符串中的一个
		[[:alnum:]] 一个字母或数字。
		[[:alpha:]]	一个字符
		[[:blank:]]	一个空格或tab
		[[:cntrl:]]	一个回车。
		[[:digit::]]|[[:d]] 一个数字
		[[:graph:]]		一个可打印字符,非空白字符。
		[[:lower:]]		一个小写字符。
		[[:print:]]		一个可打印字符。
		[[:punct:]]		一个标点符号字符，
		[[:space:]] [[:s:]]		一个空白字符。
		[[:upper:]]		一个大写字符
		[[:xdigit:]]	一个字母，数字，或下划线
	\n,\t,\f,\r,\v	换行符，制表符。
	\xhh,\uhhh		16进制字符或Unicode字符。

	*	任意次数
	?	
	+	值少一次
	{n}	n 次。
	{n,} n次以上。
	{n,m}	n-m 次。
	...|...
	(...) 设定分组。
	\1,\2,\3 第几个分组。
	\b
	\B
	^	首字符
	$	尾字符

Stream 流：可将任意数据格式化。
	

 默认不抛出异常。
	 <iosfwd>	stream class的前置声明。
	 <streambuf> 	stream buffer base class 的定义
	 <istream>		
	 <ostream>
	 <iostream>	全局性stream  除非用到标准stream否则不用引入。
全局性的stream:
	istream 	cin
	ostream	 	cout
	ostream		cerr
	ostream		clog
	wistream	wcin 	宽度一致输入到通道
	wostream	wcout	宽度一致输出到cout通道
	wostream	wcerr	宽度一致输出到err通道。
	wostream	wclog	宽度一致输出到logging通道。
stream缓冲区在写数据前，都会刷新其所对应的C stream缓存区。
sync_with_stdio(false) 取消同步。
标准操作符：
	<<,>>
状态：
	goodbit 一切OK
	eofbit	遇到end_of_file
	failbit	错误，某个I/O动作未成功。
	badbit	毁灭性错误。buff=0时此标准为始终设置。
处理状态的方法：
	  good() 返回true表示正常。
	  eof()		true遇到end_of_file
	  fail()	true表示failbit或badbit设置。
	  bad()		true 毁灭性错误
	  rdstate()	返回当前已设置的所有flag
	  clear()	清除所有flag
	  clear(state) 清除所有flag后，设置state flag
	  setstate(state)	加设flag strm.clear(strm.rdstate()& ~std::ios::failbit/求反操作)
	  <<,>> 返回值bool表示是否未出错。
异常：
	exceptions(flags)	设定“会触发异常”的flags;
	exceptions()		返回“触发异常”的flags; 返回 std::ios::iostate 类型。
	例子：
		strm.execttions(std::ios::eofbit|std::ios::failbit|std::ios::badbit); 
stream  标准I/O函数：
	streamsize 带正负号的size_t;
	  istream:
		int istream::get() 返回读取下一字符或EOF;
		istream& istream::get(char &c) 读出字符并存于变量。
		istream& istream::get(char * str,streamsize count) 读取count个字符放到流。        
		istream& istream::get(char *str,streamsize count,char delim)
		istream& istream::getline(char * str,streamsize count) 读一行xie   k
		istream& istream::getline(char * str,streamsize,cj=har delim)
		
		istream&	istream::read(char *,streamsize count) 读取count个字节，并存入str中。
		streamsize	istream::readsome(char *str, streamsize count) 可读取多达count个字符，存在str中。
		
		streamsize  istream::gcount() const	返回上一次“非格式化读取操作” 所读的字符个数。
		istream&	istream::ignore() 忽视一个字节。
		istream& 	istream::ignore(streamsize count); 忽视count字节	
		istream&	istream::ignore(streamsize count,int delim);
		
		int istream::peek(): stream 流下一个字符。不删除。
		istream& istream::unget()   把上一次读取到的数据放回流中
		istream& istream::putback(char c) 同上。
	  ostream:
	  	ostream & ostream::put(char c); 写一个char到stream;
	  	ostream & ostream::write(const char *str,streamsize count); 把str的count个值写入stream;
	  	ostream & ostream::fulsh()	刷新完成写入。
	strem 预处理/后处理：
		sentry:
		例子：
			sentry se(strm){}
	控制符：
		endl 	换行符，并清空flush the output;
		ends	表示结束的null字符。
		flush	清空输出;缓存同步。
		ws		输入并忽略空格。
		skipws	>>时跳过前导空格。
		noskipws >>时不跳过前导空格。
		unitbuf	每次写操作后清空输出缓存。
		nounitbuf 每次写操作后不清空缓存。
		setiosflags(flags) 将flags设置为标志。
		resetiosflags(m)	重置flags
		setw(value)		设置宽带。
		setfill(c)		空时填充字符。
		left			左对齐
		right			右对齐
		insternal		正负号左对齐，数字右对齐
		boolalpha		bool值使用字符显示。
		noboolalpha		bool值不用字符显示。
		showpos			正值写出+号
		noshowpos		正值不写出+号
		uppercase		数值强制使用大写字母。
		nouppercase		数值强制使用小写字母。
		oct				八进制。
		dec				十进制。
		hex				十六进制。
		showbase		显示基数。
		noshowbase		不显示基数。
		setprecision(value)	浮点精度。
		fixed			浮点使用十进制数值表示法。
		scientific		浮点使用科学计数法。
		hexfloat		浮点使用16进制表示法。
		defaultfloat	使用常规浮点表示法。
		put_time(val,fmt)	写出格式化后的时间
		get_time(val,fmt)	写入格式化后的时间。
		put_money(val)	使用本地货币符号写入货币值。
		put_money(val,intl) 根据intl写入货币值。
		get_money(val)		使用本地货币符读出货币值。
		get_money(val,intl) 根据intl读出货币值
		例子：std::cout<<std::setw(100)<<std::setfill('c')<<std::showpos<<std::left<<ac<<std::endl;
	自定义控制符:
		std::basic_ostream<T1,T2>& test(std::basic_ostream<T1,T2> &cx){
			hex(cx);
			cx.setf(std::ios_base::hex|std::ios_base::showpos);//设置样式，无参读取样式。
			return cx;
		}
		std::cout<<test<<15<<std::endl; 输出F
	类的输入输出stream重载：
		例子：
			class cout1{
				public:
					explicit cout1()=default;
					friend std::istream &operator>>(std::istream &is,cout1 c){
						return is;
					}
					friend std::ostream &operator<<(std::ostream &is,cout1 c){
						return is;
					}
				};
				int main(){
					std::cout<<cx<<std::endl;
				}
	File stream Class
		basic_ifstream
		basic_ofstream
		basic_fstream
		basic_filebuf
		文件标示符：
			in 只读
			out 只写
			app 追加
			ate 指针移动到尾部。
			trunc	清空重写
			binary	二进制数据。
			常用组合：
				out|trunc
				out|app
				in|out
				in|out|trunc
				in|app
				in|out|app
		basic_istream:
			tellg() 返回读取位置。
			seekg(pos) 设置绝对指针位置。
			seekg(pos,offset) 设置相对位置。
		basic_ostream:
			tellp()	//返回写入位置
			seekp(pos)	// 写入位置
			seekp(pos,offset) 写入相当位置。
		offset:
			std::ios_base::beg 文件开头
			std::ios_base::cur 当前位置
			std::ios_base::end 文件尾部。
			例子：
				std::string file_name="c";
				std::ofstream tsf(file_name,std::ios_base::out|std::ios_base::trunc);
				tsf<<"sadfasdfasdfasdf"<<std::endl;
				tsf.seekp(1000000,std::ios_base::beg);
				tsf<<"女郎，努力";
				tsf.flush();
				tsf.close();	
	String Stream Class
		basic_istringstream;
		basic_ostringstream;
		basic_stringbuf;
		成员函数：
			str() 返回缓冲区内容。
			str(string) 设置到缓存区。
	Stream buf:
		stream读写都由streambuf完成。
		//std::streambuf * t 
		stream::rdbuf()	返回steam的streambuf 指针。
		写字符：
			sputc(c) 将字符c送入stream缓存区。
			sputc(s,n) 将s内的n个字符送入stream缓存区。
		读字符：
			 in_avail()	返回有效的字符下界。buff里有多少数据待读。
			 sgetc()	返回当前 字符，但是不移动seek;
			 sbumpc()	返回当前字符，向后移动。
			 snextc()	seek向后移动一个字符。
			 sgetn(b,n)	读取n个字符并存到缓存区b.
			 sputbackc(c) 放一个字符到当前seek前。
			 sungetc()	seek向前移一位。
		pos：
			pubseekpos(int pos)		设置seek绝对位置。
			pubseekpos(pos,which);	设置seek绝对位置。可以设置方向。
						which:
							ios_base::cur 当前seek
							ios_base::beg	开始
							ios_base::end	结尾。
			pubseekoff(offset,rpos)	重置seek位置。
			pubseekoff(offset,rpos,which)
			pubsetbuf(buf,n)
		locales:
			pubimbue(loc)   设置locale loc
			getloc();		返回当前locale
		例子：streambuf写读文件：
			std::string file_name="test.txt";
			std::ofstream tsf(file_name,std::ios_base::binary);
			std::streambuf *tc;
			tc=tsf.rdbuf();
			for(int i=0;i<1000000;++i){
				tc->sputn((char *)&i,sizeof (i));
			}
			tsf.flush();
			tsf.close();
			std::ifstream tsr(file_name,std::ios_base::binary);
			tsr.seekg(0);
			tc=tsr.rdbuf();
			std::basic_string<char> c;
			int tmp;
			tsr.seekg(0,std::ios_base::end); //seek 移动到尾部。
			int file_size= tsr.tellg();		//获取seek位置。也就是文件大小。
			int seek=0;
			tsr.seekg(0,std::ios_base::beg);
			while (seek<file_size) {
				tc->sgetn((char *)&tmp,sizeof (tmp));
				seek=tsr.tellg();
				qDebug()<<tmp<<file_size<<seek;
			}


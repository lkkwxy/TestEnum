//
//  main.swift
//  TestEnum
//
//  Created by 李坤坤 on 2019/12/14.
//  Copyright © 2019 李坤坤. All rights reserved.
//

import Foundation

func show<T>(val: inout T) {
    print("-------------- \(type(of: val)) --------------")
    print("变量的地址:", Mems.ptr(ofVal: &val))
    print("变量的内存:", Mems.memStr(ofVal: &val))
    print("变量的大小:", Mems.size(ofVal: &val))
    print("")
}
protocol TestProtocol {
    
}
struct TestStruct: TestProtocol {
    var testPropetry1 = 10
    var testPropetry2 = 11
    var testPropetry3 = 12
//    var testPropetry4 = 13
//    var testPropetry5 = 14
}

class TestClass: TestProtocol {
    var testPropetry1 = 10
    var testPropetry2 = 11
    var testPropetry3 = 12
    var testPropetry4 = 13
    var testPropetry5 = 14
}
//测试普通e枚举
func test(){
     enum TestEnum {
       case testCase1
       case testCase2
    }
   var testEnum = TestEnum.testCase1
   show(val: &testEnum)
   testEnum = .testCase2
   show(val: &testEnum)
}
//测试case过多时
func test1(){
    var testEnum = MoreCaseEnum.case257
    show(val: &testEnum)
}
//当关联值是结构体时，前5项是结构体具体的值，最后一项区分类型类型
//枚举占用的大小为结构体的大小40+1=41，对齐之后为48
//测试关联值的类型是结构体
func test2() {
    enum TestStructEnum {
        case testCase1
        case testCase2(TestStruct)
        case testCase3
    }
    var testEnum = TestStructEnum.testCase1
    show(val: &testEnum)
    testEnum = .testCase2(TestStruct())
    show(val: &testEnum)
    testEnum = .testCase3
    show(val: &testEnum)
}

//测试关联值的类型是class
func test3() {
    enum TestClassEnum {
        case testCase1
        case testCase2(TestClass)
        case testCase3
        case testCase4
        case testCase5
        case testCase6
    }
    var testEnum = TestClassEnum.testCase1
    show(val: &testEnum)
    testEnum = .testCase2(TestClass())
    show(val: &testEnum)
    testEnum = .testCase3
    show(val: &testEnum)
    testEnum = .testCase4
    show(val: &testEnum)
    testEnum = .testCase5
       show(val: &testEnum)
    testEnum = .testCase6
       show(val: &testEnum)
}
//测试关联值的类型class+bool(这里换成其他小于4个字节l的类型都一样，比如Int16，Int8)时
func test4() {
    enum TestClassOtherEnum {
        case testCase1
        case testCase2(TestClass)
        case testCase4
        case testCase5
        case testCase6(Int8)
        case testCase7
        case testCase3(Bool)
    }
    var testEnum = TestClassOtherEnum.testCase1
    show(val: &testEnum)
    testEnum = .testCase2(TestClass())
    show(val: &testEnum)
    testEnum = .testCase3(true)
    show(val: &testEnum)
    testEnum = .testCase4
    show(val: &testEnum)
    testEnum = .testCase5
    show(val: &testEnum)
    testEnum = .testCase6(19)
    show(val: &testEnum)
    testEnum = .testCase7
    show(val: &testEnum)
}
//测试关联值的类型是占用一字节的类型时，比如bool和其他无关联值枚举
func test5() {
    enum TestEnum {
        case testCase1
        case testCase2
    }
    enum TestSamllEnum {
        case testCase1
        case testCase2(TestEnum)
        case testCase3(Bool)
    }
    var testEnum = TestSamllEnum.testCase1
    show(val: &testEnum)
    testEnum = .testCase2(.testCase2)
    show(val: &testEnum)
    testEnum = .testCase3(true)
    show(val: &testEnum)
}
//测试关联值的类型是协议时
func test6() {
    enum TestProtocolEnum {
        case testCase1
        case testCase2(TestProtocol)
        case testCase3
    }
    var testEnum = TestProtocolEnum.testCase1
    show(val: &testEnum)
    testEnum = .testCase2(TestClass())
    show(val: &testEnum)
    testEnum = .testCase2(TestStruct())
    show(val: &testEnum)
    testEnum = .testCase3
    show(val: &testEnum)
}
//测试递归枚举
func test7() {
    indirect enum TestIndirectEnum {
        case testCase1
        case testCase2(TestIndirectEnum)
        case testCase3
    }
    var testEnum = TestIndirectEnum.testCase1
    show(val: &testEnum)
    testEnum = .testCase2(.testCase3)
    show(val: &testEnum)
    testEnum = .testCase3
    show(val: &testEnum)
}
//测试复杂的递归枚举
func test8() {
    indirect enum TestIndirectEnum {
        case testCase1
        case testCase2(TestProtocol)
        case testCase3(TestIndirectEnum)
        case testCase4(TestStruct)
    }
    var testEnum = TestIndirectEnum.testCase1
    show(val: &testEnum)
    testEnum = .testCase2(TestStruct())
    show(val: &testEnum)
}


test4()

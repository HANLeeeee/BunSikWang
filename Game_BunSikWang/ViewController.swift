//
//  ViewController.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelMainTimer: UILabel!
    
    @IBOutlet weak var imageViewMe: UIImageView!
    
    @IBOutlet weak var viewHall: UIView!
    
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnDown: UIButton!
    
    @IBOutlet weak var table1: UIImageView!
    @IBOutlet weak var table2: UIImageView!
    @IBOutlet weak var table3: UIImageView!
    @IBOutlet weak var table4: UIImageView!
    @IBOutlet weak var table5: UIImageView!
    @IBOutlet weak var table6: UIImageView!
    
    @IBOutlet weak var progressView1: UIProgressView!
    
    var oneStep: CGFloat = 0.0
    
    var hour = 09
    var minutes = 00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIinit()
        
        initCustomer()
        mainDispatch()
        
      
    }
    
    func UIinit() {
        //내 캐릭터 한걸음 설정
        oneStep = (viewHall.frame.height/7)-5
        
        //손님 대기시간 타이머(프로그래스) 설정
        setProgressView(progressView: progressView1)
        setProgressView(progressView: progressView2)
        setProgressView(progressView: progressView3)
        setProgressView(progressView: progressView4)
        setProgressView(progressView: progressView5)
        setProgressView(progressView: progressView6)
    }
    
    func setProgressView(progressView: UIProgressView) {
        progressView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.white.cgColor
//        progressView.isHidden = true
    }
    
    
    //MARK: 테이블 데이터 초기화
    func initCustomer() {
        customer.append(Customer(tableImageView: table1, exist: false))
        customer.append(Customer(tableImageView: table2, exist: false))
        customer.append(Customer(tableImageView: table3, exist: false))
        customer.append(Customer(tableImageView: table4, exist: false))
        customer.append(Customer(tableImageView: table5, exist: false))
        customer.append(Customer(tableImageView: table6, exist: false))
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------
    //MARK: 메인 쓰레드
    func mainDispatch() {
        
        //MARK: 전체 타이머 재생
        DispatchQueue.global().async {
            //1. UI가 변경되기 전에 실행
            for _ in 0 ..< 540 {
                self.minutes += 01
                if self.minutes > 59 {
                    self.hour += 1
                    self.minutes = 0
                }
                DispatchQueue.main.sync {
            //2. UI업데이트
                    self.labelMainTimer.text = "\(String(format: "%02d", self.hour)) : \(String(format: "%02d", self.minutes))"
                }
            //3. UI 변경 후 실행
                print("게임시간흐르는중")
                usleep(100000)
            }
        }
        
        //MARK: 랜덤 테이블에 손님 생성
        DispatchQueue.global().async {
            //전체 타이머의 시간이 되기 전까지 반복문 실행
            while self.hour < 18 {
                //테이블 위치를 랜덤으로 받음
                let indexNum = Int.random(in: 0..<customer.count)
                //여기 담긴 시간만큼 기다렸다가 테이블에 손님생성!
                usleep(5000000)
                if customer[indexNum].exist == false {
                    DispatchQueue.main.sync {
                        customer[indexNum].tableImageView.image = UIImage(named: "icon_coming")
                        customer[indexNum].exist = true
                    }
                    print("\(indexNum)테이블 손님생성")
                } else {
                    print("테이블에 사람있음!!")
                }
            }
            
        }
    }
    
    //MARK: 주문하기 전 움직이는 모션과 타이머 설정
    //주문하기전! 들어와서 단무지 갔다주기전!!
    func beforeOrder() {
        DispatchQueue.global().async {
            let indexNum = Int.random(in: 0..<customer.count)
            if customer[indexNum].exist == false {
                DispatchQueue.main.sync {
                    customer[indexNum].tableImageView.image = UIImage(named: "icon_coming")
                    customer[indexNum].exist = true
                }
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------------------------------

    
    //버튼이벤트
    @IBAction func btnUpAction(_ sender: Any) {
        imageViewMe.layer.position = CGPoint(x: imageViewMe.center.x, y: imageViewMe.center.y-oneStep)
        tablePosition()
    }
    @IBAction func btnRightAction(_ sender: Any) {
        imageViewMe.layer.position = CGPoint(x: imageViewMe.center.x+oneStep, y: imageViewMe.center.y)
        tablePosition()
    }
    @IBAction func btnLeftAction(_ sender: Any) {
        imageViewMe.layer.position = CGPoint(x: imageViewMe.center.x-oneStep, y: imageViewMe.center.y)
        tablePosition()
    }
    @IBAction func btnDownAction(_ sender: Any) {
        imageViewMe.layer.position = CGPoint(x: imageViewMe.center.x, y: imageViewMe.center.y+oneStep)
        tablePosition()
    }
    
    
    func tablePosition() {
        let point = CGPoint(x: Int(imageViewMe.center.x)-10, y: Int(imageViewMe.center.y+10))
        if table1.frame.contains(point) {
            print("1번테이블 접근")
        } else if table2.frame.contains(point) {
            print("2번테이블 접근")
        } else if table3.frame.contains(point) {
            print("3번테이블 접근")
        } else if table4.frame.contains(point) {
            print("4번테이블 접근")
        } else if table5.frame.contains(point) {
            print("5번테이블 접근")
        } else if table6.frame.contains(point) {
            print("6번테이블 접근")
        }
    }

}


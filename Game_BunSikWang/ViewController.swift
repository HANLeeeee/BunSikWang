//
//  ViewController.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelMainTimer: UILabel!

    @IBOutlet weak var viewMe: UIView!
    @IBOutlet weak var imageViewMyMenu: UIImageView!
    
    @IBOutlet weak var viewHall: UIView!
    
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnDown: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var table1: UIImageView!
    @IBOutlet weak var table2: UIImageView!
    @IBOutlet weak var table3: UIImageView!
    @IBOutlet weak var table4: UIImageView!
    @IBOutlet weak var table5: UIImageView!
    @IBOutlet weak var table6: UIImageView!
    
    @IBOutlet weak var table1Menu: UIImageView!
    @IBOutlet weak var table2Menu: UIImageView!
    @IBOutlet weak var table3Menu: UIImageView!
    @IBOutlet weak var table4Menu: UIImageView!
    @IBOutlet weak var table5Menu: UIImageView!
    @IBOutlet weak var table6Menu: UIImageView!
    

    
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var progressView2: UIProgressView!
    @IBOutlet weak var progressView3: UIProgressView!
    @IBOutlet weak var progressView4: UIProgressView!
    @IBOutlet weak var progressView5: UIProgressView!
    @IBOutlet weak var progressView6: UIProgressView!
    
    @IBOutlet weak var viewMenu1dduk: UIView!
    @IBOutlet weak var viewMenu2kimbab: UIView!
    @IBOutlet weak var viewMenu3soondae: UIView!
    @IBOutlet weak var viewMenu4noodle: UIView!
    @IBOutlet weak var viewMenu5fry: UIView!
    @IBOutlet weak var viewMenu6dan: UIView!
    @IBOutlet weak var viewMenu7trash: UIView!
    
    @IBOutlet weak var imageViewMenu1Selected: UIImageView!
    @IBOutlet weak var imageViewMenu2Selected: UIImageView!
    @IBOutlet weak var imageViewMenu3Selected: UIImageView!
    @IBOutlet weak var imageViewMenu4Selected: UIImageView!
    @IBOutlet weak var imageViewMenu5Selected: UIImageView!
    @IBOutlet weak var imageViewMenu6Selected: UIImageView!
    @IBOutlet weak var imageViewMenu7Selected: UIImageView!
    
    
    var oneStep: CGFloat = 0.0
    
    var hour = 09
    var minutes = 00
    
    var myMenu: String = ""
    let arrayMenuImage = ["menu_dduk", "menu_kimbab", "menu_soondae", "menu_noodle", "menu_fry"]
    var arrayMenu = ["떡볶이", "김밥", "순대", "라면", "튀김"]
    
    var arrayIVMenuSelected = [UIImageView]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        initUI()
        initCustomer()

        mainTimer()
        
      
    }
    
    func initUI() {
        //내 캐릭터 한걸음 설정
        oneStep = (viewHall.frame.height/7)-5
        
        //손님 대기시간 타이머(프로그래스) 초기화 설정
        setProgressView(progressView: progressView1)
        setProgressView(progressView: progressView2)
        setProgressView(progressView: progressView3)
        setProgressView(progressView: progressView4)
        setProgressView(progressView: progressView5)
        setProgressView(progressView: progressView6)
        
        
        //내가 가지고 있는 메뉴
        imageViewMyMenu.image = UIImage()
        //테이블의 메뉴
        table1Menu.image = UIImage()
        table2Menu.image = UIImage()
        table3Menu.image = UIImage()
        table4Menu.image = UIImage()
        table5Menu.image = UIImage()
        table6Menu.image = UIImage()
        
        //메뉴화살표
        imageViewMenu1Selected.isHidden = true
        imageViewMenu2Selected.isHidden = true
        imageViewMenu3Selected.isHidden = true
        imageViewMenu4Selected.isHidden = true
        imageViewMenu5Selected.isHidden = true
        imageViewMenu6Selected.isHidden = true
        imageViewMenu7Selected.isHidden = true
        
        arrayIVMenuSelected.append(imageViewMenu1Selected)
        arrayIVMenuSelected.append(imageViewMenu2Selected)
        arrayIVMenuSelected.append(imageViewMenu3Selected)
        arrayIVMenuSelected.append(imageViewMenu4Selected)
        arrayIVMenuSelected.append(imageViewMenu5Selected)
        arrayIVMenuSelected.append(imageViewMenu6Selected)
        arrayIVMenuSelected.append(imageViewMenu7Selected)
        
        
        
        
    }
    
    func setProgressView(progressView: UIProgressView) {
        progressView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.white.cgColor
        progressView.isHidden = true
        progressView.progress = 0
    }
    
    //MARK: 테이블 데이터 초기화
    func initCustomer() {
        customerData.append(Customer(tableImageView: table1, exist: false, state: "주문전", menu: "단무지", menuImageView: table1Menu, tableTimer: progressView1, timerStart: true))
        customerData.append(Customer(tableImageView: table2, exist: false, state: "주문전", menu: "단무지", menuImageView: table2Menu, tableTimer: progressView2, timerStart: true))
        customerData.append(Customer(tableImageView: table3, exist: false, state: "주문전", menu: "단무지", menuImageView: table3Menu, tableTimer: progressView3, timerStart: true))
        customerData.append(Customer(tableImageView: table4, exist: false, state: "주문전", menu: "단무지", menuImageView: table4Menu, tableTimer: progressView4, timerStart: true))
        customerData.append(Customer(tableImageView: table5, exist: false, state: "주문전", menu: "단무지", menuImageView: table5Menu, tableTimer: progressView5, timerStart: true))
        customerData.append(Customer(tableImageView: table6, exist: false, state: "주문전", menu: "단무지", menuImageView: table6Menu, tableTimer: progressView6, timerStart: true))
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------
    //MARK: 메인 쓰레드
    func mainTimer() {
        //MARK: 전체 타이머 재생
        DispatchQueue.global().async {
            //1. UI가 변경되기 전에 실행
            while self.hour < 18 {
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
//                print("게임시간흐르는중")
                usleep(100000)
            }
        }
        
        //MARK: 랜덤 테이블에 손님 생성
        DispatchQueue.global().async {
            //전체 타이머의 시간이 되기 전까지 반복문 실행
            while self.hour < 18 {
                //테이블 위치를 랜덤으로 받음
//                let indexNum = 2
                let indexNum = Int.random(in: 0..<customerData.count)
                //여기 담긴 시간만큼 기다렸다가 테이블에 손님생성!
                usleep(5000000)
                if customerData[indexNum].exist == false {
                    DispatchQueue.main.sync {
                        print("\(indexNum)")
                        customerData[indexNum].tableImageView.image = UIImage(named: "icon_coming")
                        customerData[indexNum].exist = true
                        customerData[indexNum].tableTimer.isHidden = false
                        
                    }
                    print("\(indexNum)테이블 손님생성")
                    self.tableTimer(tableIndex: indexNum)

                } else {
                    print("\(indexNum)테이블에 사람있음")
                }
            }
        }
    }
    
    //MARK: 테이블 타이머 재생 20초
    func tableTimer(tableIndex: Int) {
        print("\(tableIndex) 타이머시작")
        DispatchQueue.global().async {
            var tableTime: Float = 0.0
            while tableTime < 1 {
                if customerData[tableIndex].state != "치우기" && customerData[tableIndex].state != "식사끝" {
                    DispatchQueue.main.sync {
                        if customerData[tableIndex].timerStart == false {
                            tableTime = 1
                        } else {
                            print("\(tableIndex)테이블 손님타이머시작")
                            customerData[tableIndex].tableTimer.progress = tableTime
                            customerData[tableIndex].tableTimer.setProgress(tableTime, animated: true)
                        }
                    }
                    tableTime += 0.05
                    usleep(1000000) //1초
                } else {
                    tableTime += 0.125
                }
        
            }
            //대기시간이 끝났을 때
            customerData[tableIndex].timerStart = true
            self.orderIng(tableIndex: tableIndex)
        }
    }
    
    func orderIng(tableIndex: Int) {
        let menuIndex = Int.random(in: 0..<self.arrayMenuImage.count)
        
        DispatchQueue.main.sync {
            switch customerData[tableIndex].state {
            case "주문전":
                print("\(tableIndex) 기분상함")
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_upset")
                customerData[tableIndex].state = "주문전1"
                
            case "주문전1":
                print("\(tableIndex) 매우화남")
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_angry")
                customerData[tableIndex].state = "주문전2"

            case "주문중":
                print("\(tableIndex) 주문")
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_order")
                customerData[tableIndex].menuImageView.image = UIImage(named: arrayMenuImage[menuIndex])
                customerData[tableIndex].menu = arrayMenu[menuIndex]
                customerData[tableIndex].state = "주문중1"
           
            case "주문중1":
                print("\(tableIndex) 주문중 기분상함")
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_upset")
                customerData[tableIndex].state = "주문중2"
                
            case "주문중2":
                print("\(tableIndex) 주문중 매우화남")
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_angry")
                customerData[tableIndex].state = "주문중3"
                
            case "식사중":
                print("\(tableIndex) 냠냠")
                customerData[tableIndex].tableTimer.isHidden = true
                
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_eating")
                customerData[tableIndex].menuImageView.image = UIImage()
                customerData[tableIndex].state = "식사끝"

            case "식사끝":
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_finish")
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].state = "치우기"

            case "치우기":
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_dirty")
                customerData[tableIndex].menu = "치우기"

                
            default:
                //나갔을 때 & state="주문전2"일때 & state="주문중3"일때
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_empty")
                customerData[tableIndex].exist = false
                customerData[tableIndex].state = "주문전"
                customerData[tableIndex].menu = "단무지"
                customerData[tableIndex].menuImageView.image = UIImage()
                customerData[tableIndex].tableTimer.isHidden = true
                
            }
        }
        
    }
   
  
    //-------------------------------------------------------------------------------------------------------------------------------------

    func finish() {
      
    }
    
    
    
    //버튼이벤트
    @IBAction func btnSubmitAction(_ sender: Any) {
        tablePosition()
        menuPosition()
    }

    @IBAction func btnUpAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x, y: viewMe.center.y-oneStep)
        tablePosition()
        menuPosition()
    }
    @IBAction func btnRightAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x+oneStep, y: viewMe.center.y)
        tablePosition()
        menuPosition()
    }
    @IBAction func btnLeftAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x-oneStep, y: viewMe.center.y)
        tablePosition()
        menuPosition()
    }
    @IBAction func btnDownAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x, y: viewMe.center.y+oneStep)
        tablePosition()
        menuPosition()
    }
    
    func tablePosition() {
        let point = CGPoint(x: Int(viewMe.center.x)-10, y: Int(viewMe.center.y+10))
        if table1.frame.contains(point) {
            print("1번테이블 접근")
            menuPick(tableIndex: 0)
        } else if table2.frame.contains(point) {
            print("2번테이블 접근")
            menuPick(tableIndex: 1)
        } else if table3.frame.contains(point) {
            print("3번테이블 접근")
            menuPick(tableIndex: 2)
        } else if table4.frame.contains(point) {
            print("4번테이블 접근")
            menuPick(tableIndex: 3)
        } else if table5.frame.contains(point) {
            print("5번테이블 접근")
            menuPick(tableIndex: 4)
        } else if table6.frame.contains(point) {
            print("6번테이블 접근")
            menuPick(tableIndex: 5)
        }
    }
    
    func menuPick(tableIndex: Int) {
        if btnSubmit.isTouchInside {
            print("제출버튼클릭")
            if customerData[tableIndex].menu == "단무지" && myMenu == "단무지" {
                customerData[tableIndex].timerStart = false
                customerData[tableIndex].state = "주문중"
                myMenu = ""
                imageViewMyMenu.image = UIImage()
                
                
            } else if customerData[tableIndex].menu == myMenu {
                customerData[tableIndex].timerStart = false
                customerData[tableIndex].state = "식사중"
                myMenu = ""
                imageViewMyMenu.image = UIImage()
                
            } else if customerData[tableIndex].menu == "치우기" && myMenu == "" {
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_empty")
                customerData[tableIndex].exist = false
                customerData[tableIndex].state = "주문전"
                customerData[tableIndex].menu = "단무지"
                
            } else {
                print("갖고있는 거랑 시킨메뉴랑 다름")
            }
        }
    }
    

    func menuPosition() {
        let point = CGPoint(x: Int(viewMe.center.x-561), y: Int(viewMe.center.y+2))
        if viewMenu1dduk.frame.contains(point) {
            print("1 떡볶이 접근")
            setImageViewMenuSelected(imageViewMenuSelected: imageViewMenu1Selected)
            setImageMyMenu(menuImage: UIImage(named: "menu_dduk")!, myMenuName: "떡볶이")
            
        } else if viewMenu2kimbab.frame.contains(point) {
            print("2 김밥 접근")
            imageViewMenu2Selected.isHidden = false
            setImageViewMenuSelected(imageViewMenuSelected: imageViewMenu2Selected)
            setImageMyMenu(menuImage: UIImage(named: "menu_kimbab")!, myMenuName: "김밥")

            
        } else if viewMenu3soondae.frame.contains(point) {
            print("3 순대 접근")
            setImageViewMenuSelected(imageViewMenuSelected: imageViewMenu3Selected)
            setImageMyMenu(menuImage: UIImage(named: "menu_soondae")!, myMenuName: "순대")

            
        } else if viewMenu4noodle.frame.contains(point) {
            print("4 라면 접근")
            setImageViewMenuSelected(imageViewMenuSelected: imageViewMenu4Selected)
            setImageMyMenu(menuImage: UIImage(named: "menu_noodle")!, myMenuName: "라면")

            
        } else if viewMenu5fry.frame.contains(point) {
            print("5 튀김 접근")
            setImageViewMenuSelected(imageViewMenuSelected: imageViewMenu5Selected)
            setImageMyMenu(menuImage: UIImage(named: "menu_fry")!, myMenuName: "튀김")
            
        } else if viewMenu6dan.frame.contains(point) {
            print("6 단무지 접근")
            setImageViewMenuSelected(imageViewMenuSelected: imageViewMenu6Selected)
            setImageMyMenu(menuImage: UIImage(named: "menu_danmuji")!, myMenuName: "단무지")
            
        } else if viewMenu7trash.frame.contains(point) {
            print("쓰레기통 접근")
            setImageViewMenuSelected(imageViewMenuSelected: imageViewMenu7Selected)
            if btnSubmit.isTouchInside {
                imageViewMyMenu.image = UIImage()
                myMenu = ""
            }
        }
    }
    
    //제출하기 눌렀을 때 가지고 있는 메뉴 변경
    func setImageMyMenu(menuImage: UIImage, myMenuName: String) {
        if btnSubmit.isTouchInside && imageViewMyMenu.image == UIImage() {
            imageViewMyMenu.image = menuImage
            myMenu = myMenuName
        }
    }
    
    func setImageViewMenuSelected(imageViewMenuSelected: UIImageView) {
        for select in arrayIVMenuSelected {
            if imageViewMenuSelected != select {
                select.isHidden = true
            } else {
                select.isHidden = false
            }
        }
    }
    
    
    
}


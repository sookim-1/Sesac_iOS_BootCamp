import Fluent
import Vapor

func routes(_ app: Application) throws {
    // /accounts
    app.get("accounts") { req in
        Account.query(on: req.db).all()
    }
    
    // /mails
    app.get("mails") { req in
        Mail.query(on: req.db).all()
    }
    
    // /mails/id
    app.get("mails",":mailId") { req -> EventLoopFuture<Mail> in
        
        Mail.find(req.parameters.get("mailId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
    }
    
    // /mails PUT
    app.put("mails") { req -> EventLoopFuture<HTTPStatus> in
        
        let mail = try req.content.decode(Mail.self)
        
        return Mail.find(mail.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.create_date = mail.create_date
                return $0.update(on: req.db).transform(to: .ok)
        }
        
    }
    
    // /mails/id DELETE
    app.delete("mails",":mailId") { req -> EventLoopFuture<HTTPStatus> in
        
        Mail.find(req.parameters.get("mailId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
        }.transform(to: .ok)
        
    }
    
    // /accounts POST
    app.post("accounts") { req -> EventLoopFuture<Account> in
        
        let account = try req.content.decode(Account.self) // content = body of http request
        return account.create(on: req.db).map { account }
        
    }
    
    // /mails POST
    app.post("mails") { req -> EventLoopFuture<Mail> in
        
        let mail = try req.content.decode(Mail.self) // content = body of http request
        return mail.create(on: req.db).map { mail }
        
    }
}

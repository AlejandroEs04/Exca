import { Link } from "react-router-dom"
import styles from './Breadcrumb.module.css'

export type BreadcrumbItem = {
    name: string
    url: string
}

type BreadcrumbProps = {
    list: BreadcrumbItem[]
}

export default function Breadcrumb({ list }: BreadcrumbProps) {
    return (
        <nav>
            <ol className={styles.breadcrumb}>
                {list.map(item => ((
                    <li><Link to={item.url}>{item.name}</Link></li>
                )))}
            </ol>
        </nav>
    )
}

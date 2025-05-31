import { motion } from 'framer-motion'
import styles from './MotionRow.module.css'
import EditIcon from '../shared/Icons/EditIcon'
import TrashIcon from '../shared/Icons/TrashIcon'
import { Task } from '../../types'

type RowProps = {
  task: Task,
  onEdit: (task: Task) => void,
  onDelete: (task: Task) => void
}

export default function MotionRow({ task, onEdit, onDelete }: RowProps) {
    console.log(task)
    return (
        <motion.div
            className={styles.motionRow}
            drag="x"
            dragConstraints={{ left: 0, right: 0 }}
            dragElastic={0.2}
            onDragEnd={(_e, info) => {
                const offsetX = info?.offset?.x ?? 0;
                if (offsetX > 100) {
                    onEdit(task);
                } else if (offsetX < -100) {
                    onDelete(task);
                }
            }}
            whileDrag={{ scale: 1.02, backgroundColor: "#f3f3f3" }}
        >
            <div className={styles.motionCell}>{task.id}</div>
            <div className={styles.motionCell}>{task.title}</div>
            <div className={styles.motionCell}>{task.description}</div>
            <div className={styles.motionCell}>{task.due_date}</div>
            <div className={styles.motionCell}>
                <div className='flex g-1'>
                    <button className={`${styles.btnIcon} text-blue`}><EditIcon /></button>
                    <button className={`${styles.btnIcon} text-red`}><TrashIcon /></button>
                </div>
            </div>
        </motion.div>
  )
}
